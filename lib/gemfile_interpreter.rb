require 'gemfile_interpreter/version'
require 'gemfile_interpreter/parser'
require 'gemfile_interpreter/readonly_bundler'
require 'json'
require 'yaml'

class GemfileInterpreter
  def initialize dir, gemfile: 'Gemfile', lockfile: nil
    gemfile_path = File.join dir, gemfile
    lockfile_path = File.join dir, (lockfile || "#{gemfile}.lock")
    @parsed = nil
    @bundler_runtime = ReadonlyBundler.load_gemfile gemfile_path, lockfile_path
    true
  end

  attr_reader :bundler_runtime

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
