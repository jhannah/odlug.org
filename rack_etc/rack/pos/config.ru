$:.unshift File.dirname(__FILE__)

require 'rubygems'
require 'rack'
require 'inventory'
require 'pos'

map '/pos' do
  run POS.new
end

map '/inv' do
  run Inventory.new
end