require 'lib/plasma.rb'

template = File.open(File.join(PLASMA_TEST, "template_test.plasma")).read
plasma = Plasma::Interpreter::PlasmaGrammarParser.new

env = Plasma::Interpreter::Env.new

p = plasma.parse template
puts p.evaluate(env)
