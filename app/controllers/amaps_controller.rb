# frozen_string_literal: true

class AmapsController < ApplicationController
  skip_before_action :need_amap!, only: :index
  skip_before_action :authenticate_user!, only: %i[show index]

  def index
    @amaps = policy_scope(Amap)
  end

  def show
    authorize @amap
  end
end
