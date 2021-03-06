module Entities
  class LinkEntity < Grape::Entity
    expose :id
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
    expose :id
    expose :display_name
    expose :shortcut
    expose :links do |tag, options|
      tag.links
    end
  end

  class SearchEntity < Grape::Entity
    expose :tags do |search, options|
      search.tags
    end
    expose :links do |search, options|
      search.links
    end
  end

  class UserEntity < Grape::Entity
    expose :id
    expose :email
    expose :username
  end
end
