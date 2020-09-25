# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Producer::Formulas', type: :request do
  let(:amap) { create(:amap, :with_producer) }
  let(:period) { create(:period, amap: amap) }
  let(:signed_user) { amap.producers.first }

  before(:each) do
    host! "#{amap.subdomain}.example.com"
  end

  login

  describe 'GET /' do
    it 'returns http success' do
      get "/producer/periods/#{period.id}/formulas/"
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /new' do
    it 'returns http success' do
      get "/producer/periods/#{period.id}/formulas/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /' do
    subject do
      post "/producer/periods/#{period.id}/formulas",
           params: {
             formula: { category: CATEGORIES.first,
                        name: 'test',
                        description: 'test',
                        price: 42.42 }
           }
    end

    it 'redirect to formulas' do
      subject
      expect(response).to redirect_to(producer_period_formulas_path(period))
    end

    context 'when formulas is invalid' do
      it do
        allow_any_instance_of(Formula).to receive(:valid?).and_return(false)
        subject
        expect(response).to have_http_status(:success)
      end
    end
  end
end
