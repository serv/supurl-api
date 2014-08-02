class Tag < ActiveRecord::Base
  has_many :links, through: :taggables
  has_many :taggables

  validates :display_name, presence: true
  validates :display_name, length: { maximum: 100 }
  validates :shortcut, presence: true
  validates :shortcut, length: { maximum: 100 }

  def self.search_by_display_name(name)
    Tag.where('display_name ~* ?', name)
  end
end
