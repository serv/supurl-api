class Taggable < ActiveRecord::Base
  belongs_to :tag
  belongs_to :link

  validates :tag_id, presence: true
  validates :link_id, presence: true
end
