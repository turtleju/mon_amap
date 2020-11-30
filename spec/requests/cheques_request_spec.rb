# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Cheques', type: :request do
  login_user

  describe 'GET /cheques' do
    it 'returns http success' do
      get '/cheques'
      expect(response).to have_http_status(:success)
    end
  end
end
