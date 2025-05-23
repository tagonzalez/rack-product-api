require 'rack'
require 'grape'
require 'csv'
require_relative './app/api'
require_relative './app/products'
require_relative './worker'

use Rack::Deflater
use Rack::Static,
  urls: ["/AUTHORS", "/openapi.yml"],
  root: File.expand_path(File.dirname(__FILE__)),
  header_rules: [
    [/AUTHORS/, { 'Cache-Control' => 'public, max-age=86400' }],
    [/openapi\.yml/, { 'Cache-Control' => 'no-store, no-cache, must-revalidate, max-age=0' }]
  ]

use Rack::Reloader, 0
run App::API
