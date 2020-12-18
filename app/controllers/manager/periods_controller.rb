# frozen_string_literal: true

class Manager::PeriodsController < Manager::ApplicationController
  def new
    @period = Period.new
    authorize @period
  end

  def create
    @period = CreatePeriod.call(period_params) do |period|
      authorize period
    end
    if @period.save
      redirect_to manager_period_period_days_path(@period)
    else
      render :new
    end
  end

  def index
    @periods = policy_scope(Period)
  end

  private

  def period_params
    params.require(:period).permit(:start_on, :finish_on, :price)
  end
end
