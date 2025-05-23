require 'sidekiq'
require 'csv'
require_relative './app/products'

Sidekiq.configure_client do |config|
  config.redis = { db: 1 }
end

Sidekiq.configure_server do |config|
  config.redis = { db: 1 }
end

class ProductsWorker
  include Sidekiq::Worker

  def perform(action, *args)
    products = Products.new
    case action
    when 'add_product'
      sleep(5) # Simulate a long-running task
      products.add_product(*args)
    else
      raise "Unknown action: #{action}"
    end
  end
end