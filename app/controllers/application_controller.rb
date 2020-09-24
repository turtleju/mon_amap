# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit

  before_action :need_amap!, unless: :devise_controller?, except: :home
  before_action :set_amap
  before_action :authenticate_user!, except: :home

  after_action :verify_authorized, except: %i[index home], unless: :devise_controller?
  after_action :verify_policy_scoped, only: :index, unless: :devise_controller?

  def pundit_user
    { user: current_user, amap: @amap }
  end

  def home
    render plain: "🙂 [#{current_user&.email}][#{current_producer&.email}]"
  end

  private

  def need_amap!
    @need_amap = true
  end

  def set_amap
    @amap = Amap.find_by(subdomain: request.subdomain)
    redirect_to root_url(subdomain: 'www') if @amap.nil? && @need_amap
  end
end
