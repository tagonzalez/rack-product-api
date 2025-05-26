module App
  class API < Grape::API
    version 'v1'
    format :json

    
    resource :products do
      before do
        error!({ error: 'Unauthorized' }, 401) unless Token.valid?(headers['Authorization'])
      end
      desc "Returns a list of products"
      get do
        ::Products.new.list_products
      end

      desc "Creates a new product"
      params do
        requires :name, type: String, desc: "Product name"
      end

      post do
        ::ProductsWorker.perform_async('add_product', params[:name])
        { message: "Product added successfully" }
      end
    end

    resource :auth do
      desc "Authenticate user"
      params do
        requires :username, type: String, desc: "Username"
        requires :password, type: String, desc: "Password"
      end

      post do
        user = ::User.find(params[:username])
        LOGGER.info "User found: #{user.inspect}"
        LOGGER.info "Authenticating user with username: #{params[:username]} and password: #{params[:password]}"

        if user && user.authenticate(params[:password])
          { message: "Authenticated successfully", token: ::Token.generate }
        else
          error!({ error: "Invalid username or password" }, 401)
        end
      end
    end

  end
end