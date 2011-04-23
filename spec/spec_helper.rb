require 'rubygems'
require 'bundler/setup'
require 'capybara/phantomjs'

spec_dir = nil

$:.detect do |dir|
  if File.exists? File.join(dir, "capybara.rb")
    spec_dir = File.expand_path(File.join(dir, "..", "spec"))
    $:.unshift(spec_dir)
  end
end

require File.join(spec_dir, "spec_helper")

RSpec.configure do |c|
  # c.filter_run :focus => true
end
