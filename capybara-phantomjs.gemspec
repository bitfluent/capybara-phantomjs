# -*- mode: ruby; encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'capybara/phantomjs/version'

Gem::Specification.new do |s|
  s.name = "capybara-phantomjs"
  s.rubyforge_project = "capybara-phantomjs"
  s.version = Capybara::Phantomjs::VERSION

  s.authors = ["Kamal Fariz Mahyuddin"]
  s.email = ["kamal.fariz@gmail.com"]
  s.description = "capybara-phantomjs is a Capybara driver for PhantomJS. It is similar to Capybara's selenium driver in that it runs tests against a fully-featured headless WebKit browser."

  s.files = Dir.glob("{lib,spec}/**/*") + %w(README.rdoc CHANGELOG.rdoc)
  s.extra_rdoc_files = ["README.rdoc"]

  s.homepage = "http://github.com/bitfluent/capybara-phantomjs"
  s.rdoc_options = ["--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.3.7"
  s.summary = "Capybara driver for Phantom.js"

  s.add_runtime_dependency("capybara", "~> 0.4.1")
  s.add_runtime_dependency("multi_json", "~> 0.0.5")
  s.add_runtime_dependency("childprocess", "~> 0.1.7")
  s.add_runtime_dependency("rest-client", "~> 1.6.1")
  s.add_runtime_dependency("yajl-ruby", "~> 0.8.2")

  s.add_development_dependency("bundler", "~> 1.0")
  s.add_development_dependency("rspec", "~> 2.0")
  s.add_development_dependency("sinatra", "~> 1.0")
end
