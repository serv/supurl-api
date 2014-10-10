class Link < ActiveRecord::Base
  attr_accessor :tags_list

  has_many :tags, through: :taggables
  has_many :taggables

  validates :title, presence: true
  validates :title, length: { maximum: 256 }
  validates :href, presence: true
  validates :href, length: { maximum: 256 }
  validates :comment, length: { maximum: 1000 }

  def update_tags(options)
    current_user = options[:current_user]
    params = options[:params]

    taggables_tag_names = params[:taggables].map {|taggable| taggable.display_name }
    tags_param = params[:tags].split(', ')
    mutated_tags = (tags_param - taggables_tag_names) + (taggables_tag_names - tags_param)

    mutated_tags.each do |tag_display_name|
      # TODO: need to write update_or_create_tag_taggables

      Tag.update_or_create_tag_taggables({
        display_name: tag_display_name,
        link_id: self.id
      })
    end
  end
end
