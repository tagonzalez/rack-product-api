# frozen_string_literal: true

module Api
  class Auth < Base
    resource :auth do
      desc 'Authenticate user'
      params do
        requires :username, type: String, desc: 'Username'
        requires :password, type: String, desc: 'Password'
      end

      post do
        user = ::User.find(params[:username])

        if user&.authenticate(params[:password])
          { message: 'Authenticated successfully', token: ::TokenService.generate }
        else
          error!({ error: 'Invalid username or password' }, 401)
        end
      end
    end
  end
end
