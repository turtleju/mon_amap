# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Subscriptions', type: :request do
  let(:amap) { create(:amap) }
  let(:signed_user) { create(:user) }

  login

  describe 'GET /cart' do
    it 'returns http success' do
      get '/cart'
      expect(response).to have_http_status(:success)
    end
  end
end
