require 'rails_helper'

RSpec.describe Taggable, :type => :model do

  let(:taggable) do
    FactoryGirl.build(:taggable,
                      link_id: '1',
                      tag_id: '2')
  end

  subject { taggable }

  it { should respond_to(:link_id) }
  it { should respond_to(:tag_id) }

  it { should validate_presence_of(:link_id) }
  it { should validate_presence_of(:tag_id) }

end
