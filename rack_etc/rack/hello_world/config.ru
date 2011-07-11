$:.unshift File.dirname(__FILE__)

require 'rubygems'
require 'rack'
require 'hello'

run HelloApp.new