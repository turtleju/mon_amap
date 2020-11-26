# frozen_string_literal: true

class DashboardController < ApplicationController
  skip_after_action :verify_authorized, only: :home

  def home
    @formulas = policy_scope(Formula)
    @current_period = Period.current
    @next_period = Period.next
  end
end
