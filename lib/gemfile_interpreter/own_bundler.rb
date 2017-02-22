require 'bundler'

class GemfileInterpreter
  OwnBundler = Bundler.dup

  module OwnBundler
    class << self
      def load_gemfile gemfile
        raise ArgumentError, 'The parameter gemfile may not be empty' if gemfile.nil? || gemfile.empty?
        reset!
        @default_gemfile = Pathname.new gemfile
        ensure_file_exists! default_gemfile
        ensure_file_exists! default_lockfile
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

      def ensure_file_exists! filename
        raise IOError, "File #{filename.inspect} not found" unless File.exists? filename
      end
    end
  end
end
