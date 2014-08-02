class Supurl::V0::TagsController < Grape::API

  namespace :tags do

    desc "Typeahead search for a tag by name", {
      params: API::Entities::TagEntity.documentation
    }
    get :search_by_name do
      tag_name = params[:displayName]
      tags = Tag.search_by_display_name(tag_name)
      present tags, with: API::Entities::TagEntity
    end

  end
end
