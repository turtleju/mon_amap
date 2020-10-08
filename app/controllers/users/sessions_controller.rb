# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  def create
    super
    sign_out :producer
  end
end
