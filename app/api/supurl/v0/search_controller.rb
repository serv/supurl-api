class Supurl::V0::SearchController < Grape::API

  namespace :search do

    desc "Typeahead search for top nav bar: links", {
      params: API::Entities::LinkEntity.documentation
    }
    get :links_nav do
      links = Link.where('title ~* ?', params[:query])
      present links, with: API::Entities::LinkEntity
    end

    desc "Typeahead search for top nav bar: tags", {
      params: API::Entities::LinkEntity.documentation
    }
    get :tags_nav do
      tags = Tag.where('display_name ~* ?', params[:query])
      present tags, with: API::Entities::TagEntity
    end

  end
end
