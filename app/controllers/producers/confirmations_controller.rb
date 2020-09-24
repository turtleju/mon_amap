# frozen_string_literal: true

class Producers::ConfirmationsController < Devise::ConfirmationsController
  def after_confirmation_path_for(_resource_name, resource)
    token = resource.send(:set_reset_password_token)
    edit_password_path(resource, reset_password_token: token)
  end
end
