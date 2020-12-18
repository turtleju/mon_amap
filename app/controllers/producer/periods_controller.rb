# frozen_string_literal: true

class Producer::PeriodsController < Producer::ApplicationController
  before_action :set_period, only: [:show]

  def index
    @periods = policy_scope(Period)
  end

  def show
    @formulas = policy_scope(Formula).where(period: @period)
  end

  private

  def set_period
    @period = Period.find(params[:id])
    authorize(@period)
  end
end
