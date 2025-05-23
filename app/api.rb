module App
  class API < Grape::API
    version 'v1'
    format :json

    resource :products do
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

  end
end