class Supurl::V0::LinksController < Grape::API

  helpers do
    def signed_in?(params)
      if params[:access_code].size > 0 && params[:api_key].size > 0
        access_code = params[:access_code]
        api_key = params[:api_key]
        client = Client.find_by(api_key: api_key)
        if client
          puts client.correct_access_code?(access_code)
          client.correct_access_code?(access_code)
        else
          false
        end
      else
        false
      end
    end
  end

  namespace :links do
    desc "Index: Return all links", {
      params: API::Entities::LinkEntity.documentation
    }
    get do
      if signed_in?(params)
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
      link = Link.find(params[:id])
      link.update!({
        title:   params[:title],
        href:    params[:href],
        comment: params[:comment]
      })
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
