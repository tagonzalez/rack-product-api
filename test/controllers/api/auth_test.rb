# frozen_string_literal: true

require_relative '../../test_helper'

class ApiAuthTest < Minitest::Test
  include Rack::Test::Methods

  def app
    Api::Base
  end

  def test_auth_success
    user_mock = Minitest::Mock.new
    user_mock.expect :authenticate, true, ['valid_password']
    User.stub :find, user_mock do
      TokenService.stub :generate, 'mocked_token' do
        post 'v1/auth', { username: 'valid_user', password: 'valid_password' }.to_json,
             { 'CONTENT_TYPE' => 'application/json' }
        assert_equal 201, last_response.status
        body = JSON.parse(last_response.body)
        assert_equal 'Authenticated successfully', body['message']
        assert_equal body['token'], 'mocked_token'
      end
    end
  end

  def test_auth_failure
    User.stub :find, nil do
      post 'v1/auth', { username: 'invalid_user', password: 'wrong_password' }.to_json,
           { 'CONTENT_TYPE' => 'application/json' }
      assert_equal 401, last_response.status
      body = JSON.parse(last_response.body)
      assert_equal 'Invalid username or password', body['error']
    end
  end
end
