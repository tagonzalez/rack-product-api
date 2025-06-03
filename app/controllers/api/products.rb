# frozen_string_literal: true

module Api
  class Products < Base
    resource :products do
      before do
        error!({ error: 'Unauthorized' }, 401) unless ::TokenService.valid?(headers['Authorization'])
      end
      desc 'Returns a list of products'
      get do
        ::Product.all
      end

      desc 'Creates a new product'
      params do
        requires :name, type: String, desc: 'Product name'
      end

      post do
        ::AddProductWorker.perform_in(5, params[:name])
        status 202
        { message: 'Request to add product has been accepted. Please wait at least 5 seconds for it to appear.' }
      end
    end
  end
end
