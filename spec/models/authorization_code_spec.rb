require 'rails_helper'

RSpec.describe AuthorizationCode, :type => :model do

  let(:authorization_code) do
    FactoryGirl.build(:authorization_code)
  end

  subject { authorization_code }

  it { should respond_to(:token) }
  it { should respond_to(:expires_at) }
  it { should respond_to(:client_id) }

end
