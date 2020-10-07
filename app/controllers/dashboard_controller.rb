# frozen_string_literal: true

class DashboardController < ApplicationController
  skip_after_action :verify_authorized, only: :home

  def home
    @formulas = policy_scope(Formula)
    @current_period = @amap.current_period
    @next_period = @amap.next_period
  end
end
