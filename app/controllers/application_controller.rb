# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit

  before_action :need_amap!, unless: :devise_controller?
  before_action :set_amap
  before_action :authenticate_user!

  after_action :verify_authorized, except: %i[index], unless: :devise_controller?
  after_action :verify_policy_scoped, only: :index, unless: :devise_controller?

  def pundit_user
    { user: current_user, producer: current_producer }
  end

  private

  def need_amap!
    @need_amap = true
  end

  def set_amap
    redirect_to root_url(subdomain: 'www') if Amap.current.nil? && @need_amap
  end
end
