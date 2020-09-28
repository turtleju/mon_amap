# frozen_string_literal: true

class PeriodDayPolicy < ApplicationPolicy
  def destroy?
    record.period.amap.manager == user && record.delivery_days.none?
  end

  def create?
    record.period.amap.manager == user
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
