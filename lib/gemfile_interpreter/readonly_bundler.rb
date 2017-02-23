require 'bundler'

class GemfileInterpreter
  ReadonlyBundler = Bundler.dup

  class GemfileMissingError < IOError; end
  class GemfileLockMissingError < IOError; end

  module ReadonlyBundler
    class << self
      def load_gemfile gemfile, lockfile
        raise ArgumentError, 'The parameter gemfile may not be empty' if gemfile.nil? || gemfile.empty?
        reset!
        @default_gemfile = Pathname.new gemfile
        @default_lockfile = Pathname.new lockfile
        ensure_file_exists! default_gemfile, GemfileMissingError
        ensure_file_exists! default_lockfile, GemfileLockMissingError
        definition.resolve
      end

      def default_gemfile
        @default_gemfile || raise("First call #load_gemfile")
      end

      def default_lockfile
        @default_lockfile || raise("First call #load_gemfile")
      end

      def default_bundle_dir
        raise NotImplementedError, 'The default_bundle_dir is not implemented and should not be evaluated'
      end

      private

      def ensure_file_exists! filename, error_class = IOError
        raise error_class, "File #{filename.inspect} not found" unless File.exists? filename
      end
    end
  end
end
