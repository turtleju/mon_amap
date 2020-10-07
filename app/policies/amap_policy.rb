# frozen_string_literal: true

class AmapPolicy < ApplicationPolicy
  def create?
    user.admin?
  end

  def producer_management?
    user.is_a?(Producer) && user.amaps.include?(amap)
  end

  def show?
    true
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
