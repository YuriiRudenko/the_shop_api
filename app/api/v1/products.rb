module TheShop
  module API
    module V1
      class Products < Grape::API
        resource :categories do
          route_param :category_id, type: Integer do
            desc "Return list of products for category"
            get :products do
              Product.where(category_id: params[:category_id]).map([:id, :name])
              # status 501
              # {
              #   error: "Not Implemented"
              # }
            end
          end
        end

        resource :products do
          desc 'Create a product'
          post do
            Product.insert(params.merge(updated_at: Time.now, created_at: Time.now))
          end

          get :popular do
            status 501
            {
              error: "Not Implemented"
            }
          end

          get :hottest do
            status 501
            {
              error: "Not Implemented"
            }
          end

          route_param :id, type: Integer do
            desc 'Return a product'
            get do
              Product.first(id: params[:id]).values.slice(:id, :name)
              # status 501
              # {
              #   error: "Not Implemented"
              # }
            end

            desc 'Update a product'            
            patch do
              product = Product.first(id: params[:id])
              product.update(params.except(:id))
              product.values.slice(*params.keys.map(&:to_sym))
            end

            desc 'Delete a product'            
            delete do
              Product.first(id: params[:id]).delete
              status 501
              {
                error: 'Not Implemented'
              }
            end

            desc 'Purchase a product'
            post :purchase do
              status 501
              {
                error: 'Not Implemented'
              }
            end
          end
        end
      end
    end
  end
end
