class Link < ActiveRecord::Base
  validates :title, presence: true
  validates :title, length: { maximum: 256 }
  validates :href, presence: true
  validates :href, length: { maximum: 256 }
  validates :comment, presence: true
  validates :comment, length: { maximum: 1000 }
end
