# frozen_string_literal: true

class Producers::SessionsController < Devise::SessionsController
  def create
    super
    sign_out :user
  end
end
