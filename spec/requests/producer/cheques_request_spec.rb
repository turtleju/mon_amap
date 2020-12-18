# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Producer::Cheques', type: :request do
  let(:signed_user) { create(:producer, :member) }

  login

  describe 'GET /index' do
    it 'returns http success' do
      get '/producer/cheques'
      expect(response).to have_http_status(:success)
    end
  end
end
