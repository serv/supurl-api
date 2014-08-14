FactoryGirl.define do
  factory :user do
    username              { username }
    email                 { email }
    password              { password }
    password_confirmation { password_confirmation }
  end
end
