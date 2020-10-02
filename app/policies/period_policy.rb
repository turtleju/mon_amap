# frozen_string_literal: true

class PeriodPolicy < ApplicationPolicy
  def create?
    amap.manager == user
  end

  def show?
    record.amap == amap
  end

  class Scope < Scope
    def resolve
      if amap
        scope.where(amap: amap)
      else
        scope.all
      end
    end
  end
end
