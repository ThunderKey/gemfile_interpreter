require 'gemfile_interpreter/version'
require 'gemfile_interpreter/parser'
require 'bundler'
require 'json'
require 'yaml'

module GemfileInterpreter
  class << self
    def load gemfile
      @gemfile = gemfile
      raise 'The parameter gemfile may not be empty' if gemfile.nil? || gemfile.empty?
      ensure_file_exists! @gemfile
      ensure_file_exists! "#{@gemfile}.lock"
      @parsed = nil
      @bundler_runtime = begin
        with_gemfile do
          Bundler.settings.temporary(no_install: true) do
            Bundler.load
          end
        end
      end
      true
    end

    def bundler_runtime
      raise "first use #load before #bundler_runtime" unless @bundler_runtime
      @bundler_runtime
    end

    def parsed
      @parsed = Parser.parse bundler_runtime.gems
    end

    def to_json
      parsed.to_json
    end

    def to_yaml
      parsed.to_yaml
    end

    private

    def with_gemfile &block
      previous = gemfile_env
      self.gemfile_env = @gemfile
      block.call
    ensure
      self.gemfile_env = previous
    end

    def gemfile_env
      ENV['BUNDLE_GEMFILE']
    end

    def gemfile_env= gemfile
      ENV['BUNDLE_GEMFILE'] = gemfile
    end

    def ensure_file_exists! filename
      raise IOError, "File #{filename.inspect} not found" unless File.exists? filename
    end
  end
end
