# frozen_string_literal: true

class Manager::PeriodDaysController < Manager::ApplicationController
  before_action :set_period, only: %i[index create]
  before_action :set_period_day, only: %i[destroy]

  def index
    @period_day = PeriodDay.new(period: @period)
    @period_days = policy_scope(PeriodDay).where(period: @period).sort_by_day
  end

  def destroy
    @period_day.destroy!
    redirect_to manager_period_period_days_path(@period_day.period),
                notice: "La date du #{l @period_day.day, format: :long} a bien été supprimée."
  end

  def create
    @period_day = PeriodDay.new(period_day_params)
    @period_day.period = @period
    authorize @period_day
    if @period_day.save
      redirect_to manager_period_period_days_path(@period_day.period),
                  notice: "La date du #{l @period_day.day, format: :long} a bien été ajoutée."
    else
      @period_days = policy_scope(PeriodDay).where(period: @period).sort_by_day
      render :index
    end
  end

  private

  def set_period
    @period = Period.find(params[:period_id])
  end

  def set_period_day
    @period_day = PeriodDay.find(params[:id])
    authorize @period_day
  end

  def period_day_params
    params.require(:period_day).permit(:day)
  end
end
