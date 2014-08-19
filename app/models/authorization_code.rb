class AuthorizationCode < ActiveRecord::Base
  belongs_to :client
end
