# frozen_string_literal: true

class PeriodDayPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
