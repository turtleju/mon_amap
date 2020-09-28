# frozen_string_literal: true

class Producer::FormulasController < Producer::BaseController
  before_action :set_period, only: %i[index new create]
  before_action :set_formula, only: %i[show]

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
      redirect_to producer_period_formulas_path(@period)
    else
      render :new
    end
  end

  def show; end

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
