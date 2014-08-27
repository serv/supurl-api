class Client < ActiveRecord::Base
  belongs_to :user
  has_many :access_codes
  has_many :refresh_codes
  has_many :authorization_codes

  before_validation :setup

  protected

    def setup
      self.api_key = SecureRandom.base64(64)
      self.api_secret = SecureRandom.base64(16)
    end
end
