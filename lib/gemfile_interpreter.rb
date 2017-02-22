require 'gemfile_interpreter/version'
require 'gemfile_interpreter/parser'
require 'gemfile_interpreter/own_bundler'
require 'json'
require 'yaml'

class GemfileInterpreter
  def initialize gemfile
    @gemfile = gemfile
    @parsed = nil
    @bundler_runtime = OwnBundler.load_gemfile @gemfile
    true
  end

  def bundler_runtime
    raise "first use #load before #bundler_runtime" unless @bundler_runtime
    @bundler_runtime
  end

  def gems
    bundler_runtime.gems
  end

  def parsed
    @parsed = Parser.parse gems
  end

  def to_json
    parsed.to_json
  end

  def to_yaml
    parsed.to_yaml
  end
end
