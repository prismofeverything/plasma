module Plasma
  module Interpreter
    class PlasmaInterpreter
      attr_accessor :env

      def initialize
        @prompt = "-----|  "
        @dir = File.dirname(__FILE__)
        @load_path = [File.join(PLASMA_ROOT, 'include'), PLASMA_PACKAGE_ROOT, @dir]

        @env = Env.new
        @env.bind!(:mu, self)
        @env.bind!(:env, @env)

        @plasma = PlasmaGrammarParser.new
        
        import 'plasma_core'
        merge 'core'
      end

      def to_s
        "plasma -- #{@env.keys}"
      end

      def to_plasma
        "eval"
      end

      def path
        @load_path
      end

      def import(rb)
        name = rb.split('/').last
        file = "#{rb}.rb"
        @load_path.each do |p|
          package = File.join(p, file)
          if File.exist? package
            load package
            @env.merge!(Plasma::Interpreter.const_get(name.classify).plasma(self))

            return true
          end
        end

        return false
      end

      def merge(plasma)
        name = plasma.split('/').last
        file = "#{plasma}.plasma"
        found = false
        value = nil
        
        @load_path.each do |p|
          package = File.join(p, file)
          if File.exist? package
            source = File.open(package, 'r')
            code = source.read.strip

            value = self.interpret(code)
            found = true
          end
        end

        return value if found
        raise NoSuchSourceException.new(plasma), "no such source #{plasma}", caller
      end
      
      def parse(code)
        tree = @plasma.parse(code)
        raise FailedToParseException.new, "failed to parse #{code}", caller if tree.nil? 

        return tree
      end

      def evaluate(tree, env=nil)
        env = @env if env.nil?
        tree.evaluate(env)
      end

      def interpret(code, env=nil)
        tree = parse(code)
        evaluate(tree, env)
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
