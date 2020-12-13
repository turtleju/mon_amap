# frozen_string_literal: true

class AmapPolicy < ApplicationPolicy
  def create?
    user.admin?
  end

  def producer_management?
    producer&.member?
  end

  def show?
    true
  end

  def manage?
    manager?
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
