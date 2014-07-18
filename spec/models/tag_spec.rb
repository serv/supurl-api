require 'rails_helper'

RSpec.describe Tag, :type => :model do

  let(:tag) do
    FactoryGirl.build(:tag,
                      display_name: 'ruby on rails',
                      shortcut: 'ruby-on-rails')
  end

  subject { tag }

  it { should respond_to(:display_name) }
  it { should respond_to(:shortcut) }

  it { should validate_presence_of(:display_name) }
  it { should ensure_length_of(:display_name).is_at_most(100) }
  it { should validate_presence_of(:shortcut) }
  it { should ensure_length_of(:shortcut).is_at_most(100) }

end
