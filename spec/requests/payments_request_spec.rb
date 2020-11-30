# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Payments', type: :request do
  let(:payment) { create(:payment) }
  let(:signed_user) { payment.user }

  login

  describe 'GET /payments/:id' do
    it 'returns http success' do
      get "/payments/#{payment.id}"
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /payments/:id/confirmed' do
    it 'returns http success' do
      get "/payments/#{payment.id}/confirmed"
      expect(response).to have_http_status(:success)
    end
  end
end
