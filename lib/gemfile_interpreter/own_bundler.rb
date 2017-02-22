require 'bundler'

OwnBundler = Bundler.dup

module OwnBundler
  class << self
    def setup gemfile
      @default_gemfile = Pathname.new gemfile
    end

    attr_reader :default_gemfile

    def default_bundle_dir
      Pathname.new File.join(default_gemfile.directory, '.bundle')
    end
  end
  reset!
end
