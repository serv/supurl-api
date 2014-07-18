class Taggable < ActiveRecord::Base
  validates :tag_id, presence: true
  validates :link_id, presence: true
end
