# frozen_string_literal: true

class SubscriptionPolicy < ApplicationPolicy
  def cart?
    user.is_a? User
  end

  def destroy?
    record.user == user
    # TODO: faire en fonction du paiement
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
