# gemfile_interpreter

## Install

In Gemfile:
```ruby
gem 'gemfile_interpreter'
```
Or global:
```bash
gem install gemfile_interpreter
```

## Usage

### CLI

Example for JSON output:
```bash
gemfile_interpreter /path/to/project/to/check
```

Example for YAML output:
```bash
gemfile_interpreter /path/to/project/to/check --yaml
```

See `gemfile_interpreter -h`

### Ruby

```ruby
interpreter = GemfileInterpreter.new('/path/to/project/to/check')
# => gemfile = 'Gemfile, lockfile = 'Gemfile.lock'
interpreter.parsed # => list of gems

# custom Gemfile
GemfileInterpreter.new('/path/to/project/to/check', gemfile: 'MyGemfile')
# => gemfile = 'MyGemfile, lockfile = 'MyGemfile.lock'

# custom Gemfile and Gemfile.lock
GemfileInterpreter.new('/path/to/project/to/check', gemfile: 'MyGemfile', lockfile: 'MyLockfile')
# => gemfile = 'MyGemfile, lockfile = 'MyLockfile'
```
