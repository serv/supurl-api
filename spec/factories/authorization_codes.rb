FactoryGirl.define do
  factory :authorization_code do
    token { 'token' }
    expires_at { '' }
    client_id { 1 }
  end
end
