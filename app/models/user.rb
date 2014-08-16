class User < ActiveRecord::Base
  has_secure_password

  validates :username,              presence: true
  validates :email,                 presence: true

  validates :username,              length: { minimum: 3 }
  validates :password,              length: { minimum: 5 }

  validates :username, uniqueness: true
  validates :email,    uniqueness: true

end
