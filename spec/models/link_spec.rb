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

end
