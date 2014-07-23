class API < Grape::API
  prefix 'api'
  format :json
  version 'v0', using: :path

  namespace :links do


    get :'' do
      Link.all
    end

    params do
      requires :id, type: Integer, desc: "Status id."
    end
    route_param :id do
      get do
        Link.find(params[:id])
      end
    end

  end
end
