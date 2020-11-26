# frozen_string_literal: true

class PeriodPolicy < ApplicationPolicy
  def create?
    amap.manager == user
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
