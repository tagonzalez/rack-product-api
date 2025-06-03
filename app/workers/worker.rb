# frozen_string_literal: true

class Worker
  include Sidekiq::Worker

  def perform(action, *args)
  end
end
