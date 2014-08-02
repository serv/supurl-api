module Entities
  class LinkEntity < Grape::Entity
    expose :title
    expose :comment
    expose :href
    expose :taggables do |link, options|
      link.taggables.map do |taggable|
        Tag.find(taggable.tag_id)
      end
    end
  end

  class TagEntity < Grape::Entity
    expose :display_name
    expose :shortcut
  end
end
