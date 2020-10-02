# frozen_string_literal: true

class DashboardController < ApplicationController
  before_action :authenticate_user!

  def home
    @formulas = policy_scope(Formula)
    @current_period = @amap.current_period
    @next_period = @amap.next_period
  end
end
