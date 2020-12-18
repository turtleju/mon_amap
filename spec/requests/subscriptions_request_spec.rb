# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Subscriptions', type: :request do
  let(:amap) { create(:amap) }
  let(:signed_user) { create(:user) }

  login

  describe 'GET /cart' do
    context 'when subscriptions in cart' do
      let(:formula) { create(:formula) }
      let!(:subscription) { create(:subscription, user: signed_user, subscribable: formula) }

      it 'returns http success' do
        get '/cart'
        expect(response).to have_http_status(:success)
      end
    end

    context 'when no item in cart' do
      it do
        get '/cart'
        expect(response).to redirect_to(user_root_path)
      end
    end
  end
end
