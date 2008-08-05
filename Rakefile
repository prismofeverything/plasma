dir = File.dirname(__FILE__)
require 'rubygems'
require 'rake'

Gem::manage_gems
require 'rake/gempackagetask'

gemspec = Gem::Specification.new do |s|
  s.name = "plasma"
  s.version = "0.0.1"
  s.author = "Ryan Spangler"
  s.email = "patch_work8848@yahoo.com"
  s.homepage = "http://kaleidomedallion.com/plasma/"
  s.platform = Gem::Platform::RUBY
  s.summary = "plasma --- a lightweight interpreted templating language in ruby"
  s.files = FileList['README', 'Rakefile', "{test,lib,bin,doc,examples}/**/*"].to_a
  s.bindir = 'bin'
  s.executables = ['plasma']
  s.require_path = 'lib'
  s.rubyforge_project = 'plasma'
  s.add_dependency "treetop"
end

Rake::GemPackageTask.new(gemspec) do |pkg|
  pkg.need_tar = true
end


