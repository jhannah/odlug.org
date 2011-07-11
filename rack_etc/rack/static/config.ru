$:.unshift File.dirname(__FILE__)

require 'rubygems'
require 'rack'

map '/static' do
  run Rack::Directory.new '../../../' # /var/www/odlug
end