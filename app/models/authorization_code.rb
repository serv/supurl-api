class AuthorizationCode < ActiveRecord::Base
  belongs_to :client

  before_validation :setup

  protected

    def setup
      self.token = SecureRandom.base64(64)
      self.expires_at = 1.minute.from_now
    end
end
