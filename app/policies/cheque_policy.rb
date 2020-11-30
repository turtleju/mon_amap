# frozen_string_literal: true

class ChequePolicy < ApplicationPolicy
  def deposit?
    Cheque.joins(payment: :subscriptions).where(cheques: { status: :init }, subscriptions: { user_id: user.id }).exists?
  end

  class Scope < Scope
    def resolve
      scope.joins(payment: :subscriptions).where(subscriptions: { user_id: user.id }).distinct
    end
  end
end
