# -*- encoding: utf-8 -*-

Gem::Specification.new do |gem|
  gem.name          = "tasque"
  gem.version       = "0.0.1.pre"
  gem.authors       = ["Blaine Schanfeldt"]
  gem.email         = ["git@blaines.me"]
  gem.homepage      = "https://github.com/blaines/tasque"
  gem.description   =
    %q{An easy to use gem for background tasks in Ruby}
  gem.summary       = %q{
    Tasque is designed to be flexible, scalable, and do as little as possible. It's multi threaded, and allows developers to easily leverage all available system resources. Anyone can create input adapters for Tasque to receive messages for processing.
  }

  gem.executables   = ['tasque']
  gem.files         = Dir.glob("{spec,lib}/**/*.rb") + %w(
                        LICENSE
                        README.md
                        tasque.gemspec
                      )
  gem.test_files    = Dir.glob("spec/**/*.rb")
  gem.require_paths = ["lib"]
  gem.bindir        = "bin"
  gem.has_rdoc      = false
  gem.required_ruby_version = '>= 1.9.2'

  gem.add_dependency('thor')

  gem.add_development_dependency('rspec')
  gem.add_development_dependency('rake')
end