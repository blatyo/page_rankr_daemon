# -*- encoding: utf-8 -*-
require File.expand_path("../lib/page_rankr_daemon/version", __FILE__)

Gem::Specification.new do |s|
  s.name        = "page_rankr_daemon"
  s.version     = PageRankrDaemon::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Allen Madsen"]
  s.email       = ["blatyo@gmail.com"]
  s.homepage    = "http://rubygems.org/gems/page_rankr_daemon"
  s.summary     = "A PageRankr skinny daemon."
  s.description = "A PageRankr skinny daemon. A server gem that provides page rank info."

  s.required_rubygems_version = ">= 1.3.6"
  s.rubyforge_project         = "page_rankr_daemon"
  s.add_dependency             "thin", "~> 1.2.7"
  s.add_dependency             "sinatra", "~> 1.0"
  s.add_dependency             "PageRankr", "~> 1.4.3"
  s.add_development_dependency "bundler", ">= 1.0.0"
  s.add_development_dependency "rspec", "= 2.0.0.rc"
  s.add_development_dependency "rack-test", "~> 0.5.6"

  s.files        = `git ls-files`.split("\n")
  s.test_files   = `git ls-files`.split("\n").map{|f| f =~ /^spec\/(.*)/ ? $1 : nil}.compact
  s.executables  = `git ls-files`.split("\n").map{|f| f =~ /^bin\/(.*)/ ? $1 : nil}.compact
  s.require_path = 'lib'
end
