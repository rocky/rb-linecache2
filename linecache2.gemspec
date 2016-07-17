require File.dirname(__FILE__) + '/lib/linecache2/version'

FILES = Dir[
  'AUTHORS',
  'COPYING',
  'ChangeLog',
  'NEWS',
  'README.md',
  'Rakefile',
  'lib/*.rb',
  'test/*.rb',
  'test/data/*.rb',
  'test/short-file'
]

Gem::Specification.new do |s|
  s.name         = "linecache2"
  s.version      = LineCache::VERSION
  s.authors      = ['R. Bernstein']
  s.date         = Time.now
  s.description  = <<-EOF
LineCache is a module for reading and caching lines. This may be useful for
example in a debugger where the same lines are shown many times.

This version works only with a Ruby 2.0 or greater.
EOF
  s.email        = 'rockyb@rubyforge.net'
  s.files        = FILES.to_a
  s.has_rdoc     = true
  s.homepage     = 'http://github.com/rocky/rb-linecache2'
  s.license      = 'GPL2'
  s.require_path = 'lib'
  s.summary      = 'Module to read and cache Ruby program files and file information'
  s.extra_rdoc_files = %w(README.md lib/tracelines.rb)

  # Make the readme file the start page for the generated html
  s.rdoc_options += %w(--main README.md)
  s.rdoc_options += ['--title', "LineCache #{LineCache::VERSION} Documentation"]

  s.required_ruby_version = '>= 2.0.0'
  s.add_development_dependency 'bundler', '~> 1.7'
end
