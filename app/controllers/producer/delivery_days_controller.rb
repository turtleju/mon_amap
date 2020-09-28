# frozen_string_literal: true

class Producer::DeliveryDaysController < Producer::BaseController
  before_action :set_formula, only: %i[present absent]
  before_action :set_period_day, only: %i[present absent]

  def present
    @delivery_day = DeliveryDay.find_or_create_by(formula: @formula, period_day: @period_day)
    render :presence
  end

  def absent
    @delivery_day = DeliveryDay.find_by(formula: @formula, period_day: @period_day)
    @delivery_day&.destroy!
    render :presence
  end

  private

  def set_formula
    @formula = Formula.find(params[:formula_id])
    authorize(@formula, :manage_delivery_days?)
  end

  def set_period_day
    @period_day = PeriodDay.find(params[:period_day_id])
  end
end
