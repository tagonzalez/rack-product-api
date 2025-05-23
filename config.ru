require 'rack'
require 'grape'
require 'csv'
require_relative './app/api'
require_relative './app/products'
require_relative './worker'

use Rack::Reloader, 0
run App::API
