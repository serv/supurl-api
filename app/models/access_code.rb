class AccessCode < ActiveRecord::Base
  belongs_to :client
  belongs_to :refresh_code
end
