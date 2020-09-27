# frozen_string_literal: true

class PeriodDaysController < ApplicationController
  before_action :set_period, only: %i[index]

  def index
    @period_days = policy_scope(PeriodDay).where(period: @period)
  end

  private

  def set_period
    @period = Period.find(params[:period_id])
  end
end
