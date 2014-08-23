require 'rails_helper'

RSpec.describe AccessCode, :type => :model do

  let(:access_code) do
    FactoryGirl.build(:access_code)
  end

  subject { access_code }

  it { should respond_to(:token) }
  it { should respond_to(:expires_at) }
  it { should respond_to(:client_id) }

  it { should belong_to(:client) }
  it { should belong_to(:refresh_code) }

end
