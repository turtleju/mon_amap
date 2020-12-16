# frozen_string_literal: true

class PaymentPolicy < ApplicationPolicy
  def show?
    record.user == user
  end

  def confirmed?
    show?
  end

  def create?
    user.subscriptions.without_payment.exists?
  end

  def confirm_deposit?
    manager? && record.status == 'pending'
  end

  class Scope < Scope
    def resolve
      scope.joins(:subscriptions).where(subscriptions: { user_id: user.id }).distinct
    end
  end
end
