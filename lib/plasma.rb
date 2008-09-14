require 'rubygems'

dir = File.dirname(__FILE__)

PLASMA_LIB = dir
PLASMA_ROOT = File.join(dir, 'plasma')
PLASMA_PACKAGE_ROOT = File.expand_path(dir + '/..')
PLASMA_TEST = File.join(PLASMA_PACKAGE_ROOT, 'test')

require File.join(PLASMA_ROOT, 'interpreter')
require File.join(PLASMA_LIB, 'extras/plasma_view')
require File.join(PLASMA_LIB, 'extras/plasma_engine')

$LOAD_PATH.unshift(dir)

module Plasma
  module Interpreter
    PLASMA = PlasmaInterpreter.new

    def self.interpret(code, env=nil)
      PLASMA.interpret(code, env)
    end
  end
end



