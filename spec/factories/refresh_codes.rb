FactoryGirl.define do
  factory :refresh_code do
    token { 'token' }
    expires_at { '' }
    client_id { 1 }
  end
end
