# frozen_string_literal: true

class Producer::FormulasController < Producer::BaseController
  before_action :set_period, only: %i[index new create]
  before_action :set_formula, only: %i[show copy_formulas_delivery_days copy_formula_delivery_days]

  def index
    @formulas = policy_scope(Formula).where(period: @period)
  end

  def new
    @formula = Formula.new
    authorize @formula
  end

  def create
    @formula = Formula.new(formula_params)
    @formula.producer = current_producer
    @formula.period = @period
    authorize @formula
    if @formula.save
      if policy(@formula).copy_formulas_delivery_days?
        redirect_to copy_formulas_delivery_days_producer_formula_path(@formula)
      else
        redirect_to producer_formula_path(@formula)
      end
    else
      render :new
    end
  end

  def show; end

  def copy_formulas_delivery_days
    @formulas = Formula.joins(:delivery_days)
                       .where(producer_id: @formula.producer_id, period_id: @formula.period_id)
                       .distinct
  end

  def copy_formula_delivery_days
    formula_to_copy = Formula.find(params[:formula_id_to_copy])
    authorize(formula_to_copy, :manage_delivery_days?)

    @formula.delivery_days.destroy_all
    time_now = Time.now
    delivery_days_attributes = formula_to_copy.delivery_days.pluck(:period_day_id).map do |period_day_id|
      {
        formula_id: @formula.id,
        period_day_id: period_day_id,
        created_at: time_now,
        updated_at: time_now
      }
    end

    DeliveryDay.insert_all(delivery_days_attributes)
    redirect_to producer_formula_path(@formula)
  end

  private

  def set_period
    @period = Period.find(params[:period_id])
  end

  def set_formula
    @formula = Formula.find(params[:id])
    authorize @formula
  end

  def formula_params
    params.require(:formula).permit(:category, :name, :description, :price)
  end
end
