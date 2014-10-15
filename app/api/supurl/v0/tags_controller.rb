class Supurl::V0::TagsController < Grape::API

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

  namespace :tags do
    desc "Show: Return a tag based on id", {
      params: API::Entities::TagEntity.documentation
    }
    params do
      requires :id, type: Integer, desc: "Tag id."
    end
    route_param :id do
      get do
        if signed_in?
          tag = Tag.find(params[:id])
          present tag, with: API::Entities::TagEntity
        else
        end
      end
    end
  end
end
