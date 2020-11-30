# frozen_string_literal: true

class PeriodPolicy < ApplicationPolicy
  def create?
    manage?
  end

  def show?
    true
  end

  def manage?
    amap.manager == user
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
