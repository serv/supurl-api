class Tag < ActiveRecord::Base
  attr_accessor :links_collection

  has_many :links, through: :taggables
  has_many :taggables

  validates :display_name, presence: true
  validates :display_name, length: { maximum: 100 }
  validates :display_name, uniqueness: true
  validates :shortcut, presence: true
  validates :shortcut, length: { maximum: 100 }
  validates :shortcut, uniqueness: true

  class << self
    def search_by_display_name(name)
      Tag.where('display_name ~* ?', name)
    end

    def update_or_create_tag_taggables(options)
      display_name = options[:display_name]
      link_id = options[:link_id]

      tag = Tag.where(display_name: display_name).first

      unless tag
        tag = Tag.create!({
                display_name: display_name,
                shortcut: display_name.downcase
              })
      end

      taggable = Taggable.create!({
                   tag_id: tag.id,
                   link_id: link_id
                 })
    end
  end

  def set_links
    links_collection = links
  end
end
