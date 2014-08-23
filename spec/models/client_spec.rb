require 'rails_helper'

RSpec.describe Client, :type => :model do

  let(:client) do
    FactoryGirl.build(:client)
  end

  subject { client }

  it { should respond_to(:api_key) }
  it { should respond_to(:api_secret) }
  it { should respond_to(:website_url) }
  it { should respond_to(:redirect_uri) }
  it { should respond_to(:name) }
  it { should respond_to(:user_id) }

  it { should belong_to(:user) }
  it { should have_many(:access_codes) }
  it { should have_many(:refresh_codes) }
  it { should have_many(:authorization_codes) }
end
