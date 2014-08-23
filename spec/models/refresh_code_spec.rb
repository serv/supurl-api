require 'rails_helper'

RSpec.describe RefreshCode, :type => :model do

  let(:refresh_code) do
    FactoryGirl.build(:refresh_code)
  end

  subject { refresh_code }

  it { should respond_to(:token) }
  it { should respond_to(:expires_at) }
  it { should respond_to(:client_id) }

  it { should belong_to(:client) }
  it { should have_one(:access_code) }

end
