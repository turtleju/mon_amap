# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Producers', type: :request do
  login
  let(:amap) { create(:amap, :with_manager) }
  let(:signed_user) { user }

  before(:each) do
    host! "#{amap.subdomain}.example.com"
  end

  describe 'GET /invitation' do
    subject { get '/producers/invitation' }

    context 'when lamba user' do
      let(:user) { create(:user) }

      it do
        expect { subject }.to raise_error(Pundit::NotAuthorizedError)
      end
    end

    context 'when amap manager' do
      let(:user) { amap.manager }

      it do
        subject
        expect(response).to have_http_status(:success)
      end
    end
  end
end
