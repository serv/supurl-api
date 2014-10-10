class Supurl::V0::LinksController < Grape::API

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

  namespace :links do
    desc "Index: Return all links", {
      params: API::Entities::LinkEntity.documentation
    }
    get do
      if signed_in?
        links = Link.includes(:taggables).all
        present links, with: API::Entities::LinkEntity
      else
      end
    end

    desc "Show: Return a link based on id", {
      params: API::Entities::LinkEntity.documentation
    }
    params do
      requires :id, type: Integer, desc: "Link id."
    end
    route_param :id do
      get do
        link = Link.find(params[:id])
        present link, with: API::Entities::LinkEntity
      end
    end

    desc "Create: Create a new link"
    params do
      requires :title,   type: String
      requires :href,    type: String
      requires :comment, type: String
    end
    post do
      raw_tags = params[:tags]
      link = Link.create!({
        title:   params[:title],
        href:    params[:href],
        comment: params[:comment]
      })

      raw_tags.each do |t|
        tag = Tag.where(shortcut: t.downcase).first

        unless tag
          tag = Tag.create!({
                  display_name: t,
                  shortcut: t.downcase
                })
        end

        taggable = Taggable.create({
                     tag_id: tag.id,
                     link_id: link.id
                   })
      end

      link.save
    end

    desc "Update: Update a link"
    params do
      requires :id,      type: Integer
      requires :title,   type: String
      requires :href,    type: String
      requires :comment, type: String
    end
    put ':id' do
      if signed_in?
        link = Link.find(params[:id])

        link.update!({
          title:   params[:title],
          href:    params[:href],
          comment: params[:comment]
        })

        link.update_tags({
          current_user: current_user,
          params: params
        })
      else
      end
    end

    desc "Destroy: Delete a status"
    params do
      requires :id, type: Integer
    end
    delete ':id' do
      link = Link.find(params[:id])
      link.destroy
    end

  end
end
