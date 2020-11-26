# frozen_string_literal: true

class SubscriptionPolicy < ApplicationPolicy
  def cart?
    user
  end

  def destroy?
    record.user == user
    # TODO: faire en fonction du paiement
  end

  class Scope < Scope
    def resolve
      scope.where(user: user)
    end
  end
end
