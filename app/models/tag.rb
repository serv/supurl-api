class Tag < ActiveRecord::Base
  has_many :links, through: :taggables
  has_many :taggables

  validates :display_name, presence: true
  validates :display_name, length: { maximum: 100 }
  validates :shortcut, presence: true
  validates :shortcut, length: { maximum: 100 }
end
