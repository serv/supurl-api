class User < ActiveRecord::Base
  before_create :create_remember_token

  has_secure_password

  has_many :clients

  validates :username, presence: true
  validates :email,    presence: true

  validates :username, length: { minimum: 3 }
  validates :password, length: { minimum: 5 }

  validates :username, uniqueness: true
  validates :email,    uniqueness: true

  validates_confirmation_of :password, if: lambda { |m| m.password.present? }

  class << self
    def new_remember_token
      SecureRandom.urlsafe_base64
    end

    def digest(token)
      Digest::SHA1.hexdigest(token.to_s)
    end
  end

  private

    def create_remember_token
      self.remember_token = User.digest(User.new_remember_token)
    end
end
