class API < Grape::API
  prefix 'api'
  format :json
  version 'v0', using: :path

  mount Supurl::V0::LinksController
end
