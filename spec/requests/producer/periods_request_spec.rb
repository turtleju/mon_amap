# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Producer::Periods', type: :request do
  let(:period) { create(:period) } # To have something on the page
  let(:signed_user) { create(:producer, :member) }

  login

  describe 'GET /' do
    it 'returns http success' do
      get '/producer/periods'
      expect(response).to have_http_status(:success)
    end
  end
end
