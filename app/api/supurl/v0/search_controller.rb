class Supurl::V0::SearchController < Grape::API

  helpers do
    def signed_in?
      current_user
    end

    def current_user
      access_code = AccessCode.find_by_token(token)
      user = User.find(access_code.user_id)
    end

    def token
      request.headers['Token']
    end
  end

  namespace :search do

    desc "Typeahead search for top nav bar: links", {
      params: API::Entities::LinkEntity.documentation
    }
    get :links_nav do
      if signed_in?
        links = Link.where('title ~* ?', params[:query])
        present links, with: API::Entities::LinkEntity
      else
      end
    end

    desc "Typeahead search for top nav bar: tags", {
      params: API::Entities::LinkEntity.documentation
    }
    get :tags_nav do
      if signed_in?
        tags = Tag.where('display_name ~* ?', params[:query])
        present tags, with: API::Entities::TagEntity
      else
      end
    end

  end
end
