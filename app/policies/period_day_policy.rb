# frozen_string_literal: true

class PeriodDayPolicy < ApplicationPolicy
  def destroy?
    Amap.current&.manager == user && record.delivery_days.none?
  end

  def create?
    Amap.current&.manager == user
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
