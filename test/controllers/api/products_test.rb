# frozen_string_literal: true

require_relative '../../test_helper'

class ApiProductsTest < Minitest::Test
  include Rack::Test::Methods

  def app
    Api::Base
  end

  def setup
    # Stub authentication to always pass
    TokenService.stub :valid?, true do
      super
    end
  end

  def test_get_products_success
    TokenService.stub :valid?, true do
      Product.stub :all, [{ id: 1, name: 'Test Product' }] do
        get '/v1/products'

        assert_equal 200, last_response.status
        body = JSON.parse(last_response.body)

        assert_kind_of Array, body
        assert_equal 'Test Product', body.first['name']
      end
    end
  end

  def test_post_products_success
    TokenService.stub :valid?, true do
      AddProductWorker.stub :perform_in, true do
        post '/v1/products', { name: 'New Product' }.to_json, { 'CONTENT_TYPE' => 'application/json' }

        assert_equal 202, last_response.status
        body = JSON.parse(last_response.body)

        assert_match(/Request to add product has been accepted/, body['message'])
      end
    end
  end

  def test_unauthorized_access
    TokenService.stub :valid?, false do
      get '/v1/products'

      assert_equal 401, last_response.status
      body = JSON.parse(last_response.body)

      assert_equal 'Unauthorized', body['error']
    end
  end
end
