# frozen_string_literal: true

# When remove subsxription to a formula.
# If it's was the only formula on the period, it's remove the subscription to this period
class RemoveFormulaToCart < ApplicationService
  def initialize(subscription)
    @subscription = subscription
    @user = subscription.user
    @period = @subscription.subscribable.period
  end

  def call
    destroy_subscription
    remove_membership
  end

  private

  def destroy_subscription
    @subscription.destroy!
  end

  def remove_membership
    return if @user.subscriptions.join_formulas.where(formulas: { period_id: @period.id }).exists?

    @user.subscriptions.find_by(subscribable: @period).destroy
  end
end
