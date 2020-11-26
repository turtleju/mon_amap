# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Dashboards', type: :request do
  let(:signed_user) { create(:user) }

  login

  describe 'GET /dashboard' do
    it 'returns http success' do
      get '/dashboard/'
      expect(response).to have_http_status(:success)
    end
  end
end
