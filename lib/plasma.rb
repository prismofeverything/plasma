require 'rubygems'

dir = File.dirname(__FILE__)

PLASMA_ROOT = File.join(dir, 'plasma')
PLASMA_PACKAGE_ROOT = File.expand_path(dir + '/..')
require File.join(PLASMA_ROOT, 'interpreter')

