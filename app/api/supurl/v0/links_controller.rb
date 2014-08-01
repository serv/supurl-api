class Supurl::V0::LinksController < Grape::API

  namespace :links do

    desc "Index: Return all links", {
      params: API::Entities::LinkEntity.documentation
    }
    get do
      links = Link.includes(:taggables).all
      present links, with: API::Entities::LinkEntity

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
