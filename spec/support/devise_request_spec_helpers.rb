# frozen_string_literal: true

module DeviseRequestSpecHelpers
  def login_user
    let(:signed_user) { FactoryBot.create(:user) }
    login
  end

  def login_admin
    let(:signed_user) { FactoryBot.create(:user, admin: true) }
    login
  end

  def login_producer
    let(:signed_user) { FactoryBot.create(:producer) }
    login
  end

  include Warden::Test::Helpers

  def login
    before(:each) do
      scope = Devise::Mapping.find_scope!(signed_user)
      login_as(signed_user, scope: scope)
    end
  end

  def sign_out(resource_or_scope)
    scope = Devise::Mapping.find_scope!(resource_or_scope)
    logout(scope)
  end
end
