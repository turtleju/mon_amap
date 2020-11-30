# frozen_string_literal: true

class AddFormulaToCart < ApplicationService
  def initialize(formula, user)
    @formula = formula
    @user = user
  end

  def call
    find_or_initialize_subscription
    calculate_price
    set_quantity
    save_in_db
    generate_membership
    @subscription
  end

  private

  def find_or_initialize_subscription
    @subscription = Subscription.find_or_initialize_by(subscribable: @formula, user: @user, payment: nil)
  end

  def calculate_price
    @subscription.price = @formula.delivery_days.in_future.count * @formula.price
  end

  # when new subscription, quantity default value is 1.
  # when existing subscription exist, call this service means to increment the quantity
  def set_quantity
    @subscription.quantity += 1 if @subscription.persisted?
  end

  def save_in_db
    @subscription.save!
  end

  def generate_membership
    return if @user.subscriptions.find_by(subscribable: @formula.period)

    @user.subscriptions.create(subscribable: @formula.period, price: @formula.period.price)
  end
end
