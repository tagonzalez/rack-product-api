# frozen_string_literal: true

require_relative '../test_helper'

class AddProductWorkerTest < Minitest::Test
  def setup
    @worker = AddProductWorker.new
  end

  def test_perform_calls_product_create
    Product.stub :create, true do
      assert @worker.perform('Test Product')
    end
  end
end
