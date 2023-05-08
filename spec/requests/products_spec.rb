require 'rails_helper'

RSpec.describe "Products", type: :request do
  describe "GET /products" do
    let!(:products) { create_list(:product, 100) }

    before do
      get "/products"
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it 'returns products' do
      expect(json).not_to be_empty
      expect(json.size).to eq(25)
    end

    it 'returns only 5 products' do
      get "/products/?page=1&per=5"
      expect(json.size).to eq(5)
    end
  end

  describe "GET /products/:code" do
    let!(:product) { create(:product) }

    before do
      get "/products/#{product.code}"
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "return requested product" do
      expect(json['code']).to eq product.code
    end
  end
end
