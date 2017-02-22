require 'bundler'

class GemfileInterpreter
  OwnBundler = Bundler.dup

  class GemfileMissingError < IOError; end
  class GemfileLockMissingError < IOError; end

  module OwnBundler
    class << self
      def load_gemfile gemfile
        raise ArgumentError, 'The parameter gemfile may not be empty' if gemfile.nil? || gemfile.empty?
        reset!
        @default_gemfile = Pathname.new gemfile
        ensure_file_exists! default_gemfile, GemfileMissingError
        ensure_file_exists! default_lockfile, GemfileLockMissingError
        load
      end

      def default_gemfile
        @default_gemfile || raise("First call #setup")
      end

      def default_lockfile
        case default_gemfile.basename.to_s
        when "gems.rb" then Pathname.new(default_gemfile.sub(/.rb$/, ".locked"))
        else Pathname.new("#{default_gemfile}.lock")
        end.untaint
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
