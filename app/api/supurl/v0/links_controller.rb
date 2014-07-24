class Supurl::V0::LinksController < Grape::API

  namespace :links do

    desc "Index: Return all links"
    get do
      Link.all
    end

    desc "Show: Return a link based on id"
    params do
      requires :id, type: Integer, desc: "Status id."
    end
    route_param :id do
      get do
        Link.find(params[:id])
      end
    end

    desc "Create: Create a new link"
    params do
      requires :title,   type: String
      requires :href,    type: String
      requires :comment, type: String
    end
    post do
      Link.create!({
        title:   params[:title],
        href:    params[:href],
        comment: params[:comment]
      })
    end

  end
end
