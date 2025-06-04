# frozen_string_literal: true

require 'minitest/autorun'
require 'rack'
require 'rack/test'
require 'sidekiq/testing'
require 'zeitwerk'
require 'grape'
require 'json'
require 'csv'

ENV['RACK_ENV'] = 'test'

# Load the application code
loader = Zeitwerk::Loader.new
loader.push_dir("#{__dir__}/../app/controllers")
loader.push_dir("#{__dir__}/../app/models")
loader.push_dir("#{__dir__}/../app/services")
loader.push_dir("#{__dir__}/../app/workers")
loader.setup

# # Configure Sidekiq for testing
# Sidekiq::Testing.inline! # Use inline mode to execute jobs immediately

module Minitest
  class Test
    include Rack::Test::Methods
  end
end
