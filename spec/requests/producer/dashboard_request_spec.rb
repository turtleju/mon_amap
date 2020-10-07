# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Producer::Dashboards', type: :request do
  let(:amap) { create(:amap, :with_producer) }
  let(:signed_user) { amap.producers.first }

  login

  before(:each) do
    host! "#{amap.subdomain}.example.com"
  end

  describe 'GET /producer' do
    it 'returns http success' do
      get '/producer'
      expect(response).to have_http_status(:success)
    end
  end
end
