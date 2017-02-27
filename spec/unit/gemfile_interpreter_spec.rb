require 'spec_helper'
require 'gemfile_interpreter'

RSpec.describe GemfileInterpreter do
  root_dir = File.dirname(File.dirname(File.dirname(__FILE__)))
  assets_dir = File.join root_dir, 'spec', 'assets'

  it 'generates a correct hash from a valid Gemfile' do
    i = GemfileInterpreter.new assets_dir
    expect(i.parsed.to_a).to eq [
      rubygems_gem('rake', '12.0.0'),
      rubygems_gem('concurrent-ruby', '1.0.4'),
      rubygems_gem('i18n', '0.8.0'),
      rubygems_gem('minitest', '5.10.1'),
      rubygems_gem('thread_safe', '0.3.5'),
      rubygems_gem('tzinfo', '1.2.2'),
      rubygems_gem('activesupport', '5.0.1'),
      rubygems_gem('builder', '3.2.3'),
      rubygems_gem('erubis', '2.7.0'),
      rubygems_gem('mini_portile2', '2.1.0'),
      rubygems_gem('nokogiri', '1.7.0.1'),
      rubygems_gem('rails-dom-testing', '2.0.2'),
      rubygems_gem('loofah', '2.0.3'),
      rubygems_gem('rails-html-sanitizer', '1.0.3'),
      rubygems_gem('actionview', '5.0.1'),
      rubygems_gem('rack', '2.0.1'),
      rubygems_gem('rack-test', '0.6.3'),
      rubygems_gem('actionpack', '5.0.1'),
      rubygems_gem('bcrypt', '3.1.11'),
      rubygems_gem('orm_adapter', '0.5.0'),
      rubygems_gem('method_source', '0.8.2'),
      rubygems_gem('thor', '0.19.4'),
      rubygems_gem('railties', '5.0.1'),
      rubygems_gem('responders', '2.3.0'),
      rubygems_gem('warden', '1.2.7'),
      rubygems_gem('devise', '4.2.0', true),
      rubygems_gem('multipart-post', '2.0.0'),
      rubygems_gem('faraday', '0.10.1'),
      rubygems_gem('hashie', '3.5.3'),
      rubygems_gem('jwt', '1.5.6'),
      rubygems_gem('multi_json', '1.12.1'),
      rubygems_gem('multi_xml', '0.6.0'),
      rubygems_gem('oauth2', '1.3.0'),
      rubygems_gem('omniauth', '1.6.1'),
      rubygems_gem('omniauth-oauth2', '1.3.1'),
      git_gem('omniauth-keltec', '0.0.1', 'https://github.com/ThunderKey/omniauth-keltec.git', 'd954a55459b48cb56be4dbbcaa1fd2afc113db5b', true),
    ]
  end

  it 'generates a correct hash from a valid Gemfile with own names' do
    i = GemfileInterpreter.new assets_dir, gemfile: 'ValidGemfile', lockfile: 'ValidGemfile.own_lock'
    expect(i.parsed.to_a).to eq [
      rubygems_gem('rake', '12.0.0'),
      rubygems_gem('concurrent-ruby', '1.0.4'),
      rubygems_gem('i18n', '0.8.0'),
      rubygems_gem('minitest', '5.10.1'),
      rubygems_gem('thread_safe', '0.3.5'),
      rubygems_gem('tzinfo', '1.2.2'),
      rubygems_gem('activesupport', '5.0.1'),
      rubygems_gem('builder', '3.2.3'),
      rubygems_gem('erubis', '2.7.0'),
      rubygems_gem('mini_portile2', '2.1.0'),
      rubygems_gem('nokogiri', '1.7.0.1'),
      rubygems_gem('rails-dom-testing', '2.0.2'),
      rubygems_gem('loofah', '2.0.3'),
      rubygems_gem('rails-html-sanitizer', '1.0.3'),
      rubygems_gem('actionview', '5.0.1'),
      rubygems_gem('rack', '2.0.1'),
      rubygems_gem('rack-test', '0.6.3'),
      rubygems_gem('actionpack', '5.0.1'),
      rubygems_gem('bcrypt', '3.1.11'),
      rubygems_gem('orm_adapter', '0.5.0'),
      rubygems_gem('method_source', '0.8.2'),
      rubygems_gem('thor', '0.19.4'),
      rubygems_gem('railties', '5.0.1'),
      rubygems_gem('responders', '2.3.0'),
      rubygems_gem('warden', '1.2.7'),
      rubygems_gem('devise', '4.2.0', true),
      rubygems_gem('multipart-post', '2.0.0'),
      rubygems_gem('faraday', '0.10.1'),
      rubygems_gem('hashie', '3.5.3'),
      rubygems_gem('jwt', '1.5.6'),
      rubygems_gem('multi_json', '1.12.1'),
      rubygems_gem('multi_xml', '0.6.0'),
      rubygems_gem('oauth2', '1.3.0'),
      rubygems_gem('omniauth', '1.6.1'),
      rubygems_gem('omniauth-oauth2', '1.3.1'),
      git_gem('omniauth-keltec', '0.0.1', 'https://github.com/ThunderKey/omniauth-keltec.git', 'd954a55459b48cb56be4dbbcaa1fd2afc113db5b', true),
    ]
  end

  it 'raises an error if the Gemfile has a reference to a local directory' do
    i = GemfileInterpreter.new root_dir
    expect { i.parsed }.to raise_error NotImplementedError
  end

  it 'raises an error if the lock file is missing' do
    expect { GemfileInterpreter.new assets_dir, gemfile: 'GemfileWithoutLock' }.to raise_error GemfileInterpreter::GemfileLockMissingError
  end

  it 'raises an error if the Gemfile is missing' do
    expect { GemfileInterpreter.new assets_dir, gemfile: 'MissingGemfile' }.to raise_error GemfileInterpreter::GemfileMissingError
  end

  private

  def rubygems_gem name, version, in_gemfile = false
    gem name, version, {'type' => 'rubygems', 'remotes' => ['https://rubygems.org/']}, in_gemfile
  end

  def git_gem name, version, uri, revision, in_gemfile = false
    gem name, version, {'type' => 'git', 'revision' => revision, 'uri' => uri}, in_gemfile
  end

  def gem name, version, source, in_gemfile
    [name, {'version' => version, 'full_name' => "#{name}-#{version}", 'platform' => 'ruby', 'remote' => '', 'source' => source, 'in_gemfile' => in_gemfile}]
  end
end
