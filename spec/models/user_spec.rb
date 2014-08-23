require 'rails_helper'

RSpec.describe User, :type => :model do

  let(:user) do
    FactoryGirl.build(:user,
                      username: 'ruby on rails',
                      email: 'ruby-on-rails',
                      password: 'wowfake1',
                      password_confirmation: 'wowfaker1')
  end

  subject { user }

  it { should respond_to(:username) }
  it { should respond_to(:email) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }

  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:email) }

  it { should ensure_length_of(:username).is_at_least(3) }
  it { should ensure_length_of(:password).is_at_least(5) }

  it { should validate_uniqueness_of(:username) }
  it { should validate_uniqueness_of(:email) }

  it { should have_many(:clients) }

end
