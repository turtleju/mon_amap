# frozen_string_literal: true

class PeriodsController < ApplicationController
  before_action :set_period, only: %i[show]

  def new
    @period = Period.new
    authorize @period
  end

  def create
    @period = CreatePeriod.call(period_params, @amap) do |period|
      authorize period
    end
    if @period.save
      redirect_to period_period_days_path(@period)
    else
      render :new
    end
  end

  def index
    @periods = policy_scope(Period)
  end

  def show; end

  private

  def set_period
    @period = Period.find(params[:id])
    authorize @period
  end

  def period_params
    params.require(:period).permit(:start_on, :finish_on, :price)
  end
end
