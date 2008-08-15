require 'rubygems'

dir = File.dirname(__FILE__)

PLASMA_ROOT = File.join(dir, 'plasma')
PLASMA_PACKAGE_ROOT = File.expand_path(dir + '/..')
PLASMA_TEST = File.join(PLASMA_PACKAGE_ROOT, 'test')

require File.join(PLASMA_ROOT, 'interpreter')
require File.join(PLASMA_ROOT, 'template')

$LOAD_PATH.unshift(dir)
