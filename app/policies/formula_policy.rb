# frozen_string_literal: true

class FormulaPolicy < ApplicationPolicy
  def create?
    user.is_a?(Producer) && amap && user.amaps.where(id: amap.id).exists?
  end

  def show?
    user.is_a?(Producer) && record.producer == user
  end

  def manage_delivery_days?
    user.is_a?(Producer) && record.producer == user
  end

  class Scope < Scope
    def resolve
      if user.is_a? Producer
        relation = scope.where({ producer_id: user.id })
        relation = relation.joins(:period).where(periods: { amap_id: amap.id }) if amap
        relation
      else
        scope.all
      end
    end
  end
end
