# frozen_string_literal: true

module Api
  class Base < Grape::API
    version 'v1'
    format :json

    mount Api::Products
    mount Api::Auth
  end
end
