# frozen_string_literal: true

require_relative '../../test_helper'

class ApiAuthTest < Minitest::Test
  include Rack::Test::Methods

  def app
    Api::Base
  end

  def make_request(username, password)
    post 'v1/auth', { username: username, password: password }.to_json,
         { 'CONTENT_TYPE' => 'application/json' }
  end

  def authenticated_user_mock
    user_mock = Minitest::Mock.new
    user_mock.expect :authenticate, true, ['valid_password']
    user_mock
  end

  def test_auth_success
    user_mock = authenticated_user_mock
    User.stub :find, user_mock do
      TokenService.stub :generate, 'mocked_token' do
        make_request('valid_user', 'valid_password')

        assert_equal 201, last_response.status
        body = JSON.parse(last_response.body)

        assert_equal 'Authenticated successfully', body['message']
        assert_equal 'mocked_token', body['token']
      end
    end
  end

  def test_auth_failure
    User.stub :find, nil do
      make_request('invalid_user', 'invalid_password')

      assert_equal 401, last_response.status
      body = JSON.parse(last_response.body)

      assert_equal 'Invalid username or password', body['error']
    end
  end
end
