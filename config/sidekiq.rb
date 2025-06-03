# frozen_string_literal: true

require 'sidekiq'
require 'csv'
require 'zeitwerk'

loader = Zeitwerk::Loader.new
loader.push_dir("#{__dir__}/../app/services")
loader.push_dir("#{__dir__}/../app/models")
loader.push_dir("#{__dir__}/../app/workers")
loader.setup

Sidekiq.configure_client do |config|
  config.redis = { db: 0 }
end

Sidekiq.configure_server do |config|
  config.redis = { db: 0 }
end
