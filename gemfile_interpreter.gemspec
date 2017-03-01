require File.expand_path('../lib/gemfile_interpreter/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name          = 'gemfile_interpreter'
  gem.version       = GemfileInterpreter::VERSION
  gem.platform    = Gem::Platform::RUBY
  gem.date          = '2017-02-22'
  gem.summary       = 'Gemfile Interpreter'
  gem.description   = 'A tool to interpret the Gemfile without installing it'
  gem.authors       = ['Nicolas Ganz']
  gem.email         = 'nicolas@kelte.ch'
  gem.files         = `git ls-files -- lib/*`.split("\n")
  gem.require_path  = 'lib'
  gem.test_files    = `git ls-files -- spec/*`.split("\n")
  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.license       = 'MIT'
  gem.homepage      = 'https://github.com/ThunderKey/gemfile_interpreter'

  gem.add_runtime_dependency 'bundler', '~> 1.0'
  gem.add_development_dependency 'rspec', '~> 3.0'
  gem.add_development_dependency 'pry', '~> 0'
end
