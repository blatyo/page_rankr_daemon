require File.join(File.dirname(__FILE__), '..', 'lib', 'page_rankr_daemon')

require 'rubygems'
require 'sinatra'
require 'rack/test'
require 'rspec'
require 'page_rankr'

# set test environment
set :environment, :test
set :run, false
set :raise_errors, true
set :logging, false