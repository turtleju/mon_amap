# frozen_string_literal: true

class PeriodsController < ApplicationController
  def new
    @period = Period.new
    authorize @period
  end

  def create
    @period = Period.new(period_params)
    @period.amap = @amap
    authorize @period
    if @period.save
      redirect_to periods_path
    else
      render :new
    end
  end

  def index
    @periods = policy_scope(Period)
  end

  private

  def period_params
    params.require(:period).permit(:start_on, :finish_on)
  end
end
