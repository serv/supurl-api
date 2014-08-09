class Supurl::V0::TagsController < Grape::API

  namespace :tags do
    desc "Show: Return a tag based on id", {
      params: API::Entities::TagEntity.documentation
    }
    params do
      requires :id, type: Integer, desc: "Tag id."
    end
    route_param :id do
      get do
        tag = Tag.find(params[:id])
        present tag, with: API::Entities::TagEntity
      end
    end
  end
end
