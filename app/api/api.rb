class API < Grape::API
  include Entities

  prefix 'api'
  format :json
  version 'v0', using: :path

  # API
  mount Supurl::V0::LinksController
  mount Supurl::V0::TagsController
  mount Supurl::V0::SearchController
  mount Supurl::V0::UsersController
  mount Supurl::V0::SessionsController
end
