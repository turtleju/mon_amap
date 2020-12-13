require 'rails_helper'

RSpec.describe "Manager::Cheques", type: :request do

  describe "GET /confirm_deposit" do
    it "returns http success" do
      get "/admin/cheques/confirm_deposit"
      expect(response).to have_http_status(:success)
    end
  end

end
