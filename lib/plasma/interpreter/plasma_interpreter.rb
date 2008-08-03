module Plasma
  module Interpreter
    class PlasmaInterpreter
      attr_accessor :env

      def initialize
        @prompt = "-----|  "
        @dir = File.dirname(__FILE__)
        @load_path = [@dir]

        @env = Env.new
        @env.bind!(:mu, self)
        @env.bind!(:env, @env)

        @plasma = PlasmaGrammarParser.new
        
        import 'plasma_core'
#         merge 'core.psm'
      end

      def to_s
        "plasma -- #{@env.keys}"
      end

      def path
        @load_path
      end

      def import(rb)
        file = "#{rb}.rb"
        @load_path.each do |p|
          package = File.join(p, file)
          if File.exist? package
            load package
            @env.merge!(Plasma::Interpreter.const_get(rb.classify).plasma(self))
          end
        end
      end

      def merge(psm)
        source = File.open(psm, 'r')
        code = source.read.strip
        value = interpret code

        return value
      end
      
      def interpret(code, environment=nil)
        environment = @env if environment.nil?
        parsed = @plasma.parse(code)

        raise FailedToParseException.new, "failed to parse #{code}", caller if parsed.nil? 

        parsed.evaluate(environment)
      end

      def repl
        while true
          begin
            STDOUT.write(@prompt)
            input = STDIN.readline.strip
            break if input == 'quit' or input == 'exit'

            value = interpret input

            STDOUT.write("  #{value.to_plasma}\n")
          rescue Exception => e
            STDOUT.write("  #{e.to_s}\n")
          end
        end
      end
    end
  end
end
