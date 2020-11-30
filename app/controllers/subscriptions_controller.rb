# frozen_string_literal: true

class SubscriptionsController < ApplicationController
  before_action :set_formula, only: %i[add_cart]
  before_action :set_subscription, only: %i[destroy]
  before_action :set_subscriptions, only: %i[cart cart_payments]

  skip_after_action :verify_authorized, only: %i[cart cart_payments]
  after_action :verify_policy_scoped, only: %i[cart cart_payments]

  def add_cart
    @subscription = AddFormulaToCart.call(@formula, current_user)
    render :update_period_formula_card
  end

  def destroy
    RemoveFormulaToCart.call(@subscription)
    @formula = @subscription.subscribable
    render :update_period_formula_card
  end

  def cart; end

  def cart_payments
    @subscription_period   = @subscriptions.find_by(subscribable_type: 'Period')
    @subscriptions_grouped = @subscriptions.where(subscribable_type: 'Formula').group_by { |s| s.subscribable.producer }
    add_payments_monthly_and_annually
  end

  private

  def add_payments_monthly_and_annually
    @subscriptions_grouped.each do |producer, subscriptions|
      amount = subscriptions.inject(0) { |sum, subscription| sum + subscription.price * subscription.quantity }
      @round = params[:round] == 'true'
      @subscriptions_grouped[producer] =
        {
          monthly: AllocateSumByMonth.call(@period, amount.cents, months_without_cents: @round),
          annually: amount.cents
        }
    end
  end

  def set_formula
    @formula = Formula.find(params[:formula_id])
    authorize @formula
  end

  def set_subscription
    @subscription = Subscription.find(params[:id])
    authorize @subscription
  end

  def set_subscriptions
    @subscriptions = policy_scope(Subscription).without_payment

    periods = @subscriptions.all.map do |s|
      case s.subscribable
      when Formula then s.subscribable.period
      when Period then s.subscribable
      end
    end.uniq

    raise 'multiple periods in cart' if periods.size > 1

    @period = periods.first
  end
end
