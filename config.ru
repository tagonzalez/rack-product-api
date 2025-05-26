require 'rack'
require 'grape'
require 'grape-swagger'
require 'csv'
require 'securerandom'
require 'logger'
require_relative './app/api'
require_relative './app/products'
require_relative './worker'
require_relative './app/token'
require_relative './app/user'

LOGGER = Logger.new(STDOUT)
LOGGER.level = Logger::DEBUG
LOGGER.debug("Starting Rack application...")

use Rack::Deflater
use Rack::Static,
  urls: ["/AUTHORS", "/openapi.yml"],
  root: File.expand_path(File.dirname(__FILE__)),
  header_rules: [
    [/AUTHORS/, { 'cache-control' => 'public, max-age=86400' }],
    [/openapi\.yml/, { 'cache-control' => 'no-store, no-cache, must-revalidate, max-age=0' }]
  ]

use Rack::Reloader, 0
run App::API
