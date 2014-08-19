FactoryGirl.define do
  factory :client do
    api_key { 'SecureToken.generate(16) '}
    api_secret { 'SecureToken.generate' }
    website_url { 'http://google.com' }
    redirect_uri { '/analytics' }
    name { 'Analytics' }
    user_id { 1 }
  end
end
