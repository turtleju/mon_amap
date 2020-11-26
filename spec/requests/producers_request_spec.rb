# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Producers', type: :request do
  login

  describe 'GET /invitation' do
    subject { get '/producers/invitation' }

    context 'when lamba user' do
      let(:signed_user) { create(:user) }

      it do
        expect { subject }.to raise_error(Pundit::NotAuthorizedError)
      end
    end

    context 'when amap manager' do
      let(:signed_user) { Amap.current.manager }

      it do
        subject
        expect(response).to have_http_status(:success)
      end
    end
  end
end
