# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Admin::Amaps', type: :request do
  login

  let(:signed_user) { FactoryBot.create(:user, admin: true) }

  describe 'GET /amaps' do
    subject { get '/admin/amaps' }

    it 'returns http success' do
      subject
      expect(response).to have_http_status(:success)
    end

    context 'when user' do
      let(:signed_user) { FactoryBot.create(:user) }

      it 'returns http forbidden' do
        expect { subject }.to raise_error(ActionController::RoutingError)
      end
    end

    context 'when producer' do
      let(:signed_user) { FactoryBot.create(:producer) }

      it 'returns http forbidden' do
        subject
        expect(response).not_to have_http_status(:success)
      end
    end
  end
end
