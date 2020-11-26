# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Producer::Formulas', type: :request do
  let(:period) { create(:period) }
  let(:signed_user) { create(:producer, :member) }

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
      expect(response).to redirect_to(producer_formula_path(Formula.last))
    end

    context 'when can copy other formulas delivery days' do
      it 'redirect to copy_formulas_delivery_days_producer_formula_path' do
        allow_any_instance_of(FormulaPolicy).to receive(:copy_formulas_delivery_days?).and_return(true)
        subject
        expect(response).to redirect_to(copy_formulas_delivery_days_producer_formula_path(Formula.last))
      end
    end

    context 'when formulas is invalid' do
      it do
        allow_any_instance_of(Formula).to receive(:valid?).and_return(false)
        subject
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe '#show' do
    it 'TODO'
  end
end
