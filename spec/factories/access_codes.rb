FactoryGirl.define do
  factory :access_code do
    token { 'token' }
    expires_at { '' }
    client_id { 1 }
  end
end
