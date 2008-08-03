require 'rubygems'
require 'treetop'
load 'plasma.rb'
load 'plasmanode.rb'
load 'plasmacore.rb'

class PlasmaInterpreter
  attr_accessor :env

  def initialize
    @prompt = "-----|  "

    @env = Env.new
    @env.bind!(:mu, self)
    @env.bind!(:env, @env)

    @plasma = PlasmaParser.new
    
    import 'plasmacore'
    merge 'core.psm'
  end

  def to_s
    "plasma -- #{@env.keys}"
  end

  def import(rb)
    load "#{rb}.rb"

    @env.merge!(Object.const_get(rb.classify).plasma(self))
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


