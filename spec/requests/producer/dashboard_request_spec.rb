# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Producer::Dashboards', type: :request do
  let(:signed_user) { create(:producer, :member) }

  login

  describe 'GET /producer' do
    it 'returns http success' do
      get '/producer'
      expect(response).to have_http_status(:success)
    end
  end
end
