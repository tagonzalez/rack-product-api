# frozen_string_literal: true

require 'rack'
require 'grape'
require 'grape-swagger'
require 'csv'
require 'securerandom'
require 'logger'
require 'zeitwerk'
require 'sidekiq'

loader = Zeitwerk::Loader.new
loader.push_dir("#{__dir__}/app/controllers")
loader.push_dir("#{__dir__}/app/models")
loader.push_dir("#{__dir__}/app/services")
loader.push_dir("#{__dir__}/app/workers")
loader.enable_reloading
loader.setup

LOGGER = Logger.new($stdout)
LOGGER.level = Logger::DEBUG
LOGGER.debug('Starting Rack application...')

use Rack::Deflater
use Rack::Static,
    urls: ['/AUTHORS', '/openapi.yml'],
    root: __dir__,
    header_rules: [
      [/AUTHORS/, { 'cache-control' => 'public, max-age=86400' }],
      [/openapi\.yml/, { 'cache-control' => 'no-store, max-age=0' }]
    ]

use Rack::Reloader, 0
run Api::Base
