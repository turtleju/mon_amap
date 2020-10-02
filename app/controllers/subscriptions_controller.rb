# frozen_string_literal: true

class SubscriptionsController < ApplicationController
  before_action :set_formula, only: %i[add_cart]
  before_action :set_subscription, only: %i[destroy]

  skip_after_action :verify_authorized, only: [:cart]
  after_action :verify_policy_scoped, only: [:cart]

  def add_cart
    @subscription = AddFormulaToCart.call(@formula, current_user)
    render :update_period_formula_card
  end

  def destroy
    RemoveFormulaToCart.call(@subscription)
    @formula = @subscription.subscribable
    render :update_period_formula_card
  end

  def cart
    @subscriptions = policy_scope(Subscription)
  end

  private

  def set_formula
    @formula = Formula.find(params[:formula_id])
    authorize @formula
  end

  def set_subscription
    @subscription = Subscription.find(params[:id])
    authorize @subscription
  end
end
