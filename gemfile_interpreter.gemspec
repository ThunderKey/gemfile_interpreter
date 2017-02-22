require File.expand_path('../lib/gemfile_interpreter/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name        = 'gemfile_interpreter'
  gem.version     = '0.0.0'
  gem.date        = '2010-04-28'
  gem.summary     = 'Gemfile Interpreter'
  gem.description = 'A tool to interpret the Gemfile without installing it'
  gem.authors     = ['Nicolas Ganz']
  gem.email       = 'nicolas@kelte.ch'
  gem.files       = %w{
    Gemfile
    bin/gemfile_interpreter
    lib/gemfile_interpreter.rb
    lib/gemfile_interpreter/version.rb
    lib/gemfile_interpreter/parser.rb
    lib/gemfile_interpreter/own_bundler.rb
  }
  gem.require_path = 'lib'
  gem.executables << 'gemfile_interpreter'
  gem.license     = 'MIT'
  gem.homepage    = 'https://github.com/ThunderKey/gemfile_interpreter'

  gem.add_dependency 'bundler', '~> 1.0'
end
