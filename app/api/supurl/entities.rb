module Entities
  class LinkEntity < Grape::Entity
    expose :title
    expose :comment
    expose :href
    expose :taggables do |link, options|
      link.taggables.map do |taggable|
        Tag.find(taggable.id)
      end
    end
  end
end
