# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'PeriodDays', type: :request do
  let(:amap) { create(:amap, :with_manager) }
  let(:signed_user) { amap.manager }
  let(:period) { create(:period, amap: amap) }
  let!(:period_day) { create(:period_day, period: period) }

  login

  before(:each) do
    host! "#{amap.subdomain}.example.com"
  end

  describe 'GET /periods/:period_id/period_days' do
    it 'returns http success' do
      get "/periods/#{period.id}/period_days"
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /periods/:period_id/period_days' do
    it 'create a period_day'
  end

  describe 'DELETE /period_days/:id' do
    it 'destroy a period_day'
  end
end
