# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Manager::Periods', type: :request do
  login
  let(:signed_user) { Amap.current.manager }

  describe 'GET /new' do
    it 'returns http success' do
      get '/manager/periods/new'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /' do
    it 'returns http success' do
      get '/manager/periods'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /' do
    it 'call CreatePeriod service'
    context 'when created' do
      it 'redirect to period_period_days_path'
    end

    context 'when save failed' do
      it 'have_http_status(:success)'
    end
  end
end
