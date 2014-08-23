class RefreshCode < ActiveRecord::Base
  belongs_to :client
  has_one :access_code
end
