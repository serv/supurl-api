require 'rails_helper'

RSpec.describe Link, :type => :model do

  let(:link) do
    FactoryGirl.build(:link,
                      title: 'This is a title',
                      href: 'www.google.chom',
                      comment: 'Hello world')
  end

  subject { link }

  it { should respond_to(:title) }
  it { should respond_to(:href) }
  it { should respond_to(:comment) }

  it { should validate_presence_of(:title) }
  it { should ensure_length_of(:title).is_at_most(256) }
  it { should validate_presence_of(:href) }
  it { should ensure_length_of(:href).is_at_most(256) }
  it { should validate_presence_of(:comment) }
  it { should ensure_length_of(:comment).is_at_most(1000) }

end
