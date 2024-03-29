# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Manager::Dashboards', type: :request do
  login
  let(:signed_user) { Amap.current.manager }

  describe 'GET /home' do
    it 'returns http success' do
      get '/manager'
      expect(response).to have_http_status(:success)
    end
  end
end
