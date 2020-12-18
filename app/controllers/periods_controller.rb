# frozen_string_literal: true

class PeriodsController < ApplicationController
  before_action :set_period, only: %i[show]

  def show; end

  private

  def set_period
    @period = Period.find(params[:id])
    authorize @period
  end
end
