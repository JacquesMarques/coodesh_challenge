require 'rails_helper'

RSpec.describe "Homes", type: :request do
  describe "GET /index" do
    before do
      get "/home/index"
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "returns text" do
      expect(response.body).to eq 'Fullstack Challenge 20201026'
    end
  end
end
