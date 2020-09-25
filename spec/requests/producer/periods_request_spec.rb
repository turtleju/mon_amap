# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Producer::Periods', type: :request do
  let(:amap) { create(:amap, :with_producer) }
  let(:period) { create(:period, amap: amap) } # To have something on the page
  let(:signed_user) { amap.producers.first }

  before(:each) do
    host! "#{amap.subdomain}.example.com"
  end

  login

  describe 'GET /' do
    it 'returns http success' do
      get '/producer/periods'
      expect(response).to have_http_status(:success)
    end
  end
end
