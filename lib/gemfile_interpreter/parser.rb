module GemfileInterpreter
  module Parser
    class << self
      def parse gems
        hash = {}
        gems.each do |gem|
          hash[gem.name] = parse_gem gem
        end
        hash
      end

      def parse_gem gem
        hash = {}
        [:version, :full_name, :platform, :remote].map do |method|
          hash[method.to_s] = gem.send(method).to_s
        end
        hash['source'] = parse_source gem.source
        hash
      end

      def parse_source source
        source_type = if source.is_a? Bundler::Source::Rubygems
          # normal rubygems.org
          'rubygems'
        elsif source.is_a? Bundler::Source::Git
          # git
          'git'
        else
          raise "unknown type #{source.inspect}"
        end
        {'type' => source_type}.merge(source.options)
      end
    end
  end
end
