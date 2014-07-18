require 'spec_helper'

describe Link do
  let(:link) do
    FactoryGirl.build(:link,
                              title: 'This is a title',
                              href: 'www.google.chom',
                              comment: 'Hello world')
  end

  subject { link }

  it { should respond_to(:title) }
  it { should respond_to(:herf) }
  it { should respond_to(:comment) }

end
