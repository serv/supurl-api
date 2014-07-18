class Tag < ActiveRecord::Base
  validates :title, presence: true, length: { max: 256 }
  validates :href, presence: true, length: { max: 256 }
  validates :comment, presence: true, length: { max: 1000 }
end
