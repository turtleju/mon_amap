# frozen_string_literal: true

class Admin::AmapsController < ApplicationController
  skip_before_action :need_amap!

  def index
    @amaps = policy_scope(Amap)
  end

  def new
    @amap = Amap.new
    authorize(@amap)
  end

  def create
    @amap = Amap.new(amap_params)
    authorize(@amap)
    @amap.save!
    redirect_to admin_amaps_path, notice: 'Amap bien créée.'
  end

  private

  def amap_params
    params.require(:amap).permit(%I[name description subdomain legal_address distribution_address latitude longitude])
  end
end
