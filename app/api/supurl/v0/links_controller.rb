class Supurl::V0::LinksController < Grape::API

  namespace :links do

    desc "Return all links"
    get :'' do
      Link.all
    end

    desc "Return a link based on id"
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
