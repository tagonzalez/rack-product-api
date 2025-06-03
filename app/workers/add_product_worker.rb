# frozen_string_literal: true

class AddProductWorker
  include Sidekiq::Worker

  def perform(name)
    Product.create(name)
  end
end
