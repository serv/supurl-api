class Client < ActiveRecord::Base
  belongs_to :user
  has_many :access_codes
  has_many :refresh_codes
  has_many :authorization_codes
end
