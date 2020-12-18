# frozen_string_literal: true

class ChequePolicy < ApplicationPolicy
  def deposit?
    Cheque.joins(payment: :subscriptions)
          .where(cheques: { status: Cheque::STATUS_INIT }, subscriptions: { user_id: user.id })
          .exists?
  end

  class Scope < Scope
    def resolve
      if user
        scope.joins(payment: :subscriptions).where(subscriptions: { user_id: user.id }).distinct
      elsif producer
        scope.where(producer: producer)
      else
        scope.none
      end
    end
  end
end
