require 'rails_helper'

describe Supurl::V0::LinksController do

  describe "GET /api/v0/links" do
    it "return all links" do
      get "/api/v0/links"
      expect(response.status).to eq(200)
      expect(JSON.parse(response.body)).to eq([])
    end
  end

  describe "POST /api/v0/links", broken: true do
    it "create a link" do
      link = FactoryGirl.build(:link,
                                title: 'This is a title',
                                href: 'www.google.chom',
                                comment: 'Hello world')
      path = "/api/v0/links"

      post(path, link.to_json)

      expect(response.status).to eq(201)
      expect(Link.all.count).to eq(1)
    end
  end

end
