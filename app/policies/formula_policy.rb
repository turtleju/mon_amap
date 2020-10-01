# frozen_string_literal: true

class FormulaPolicy < ApplicationPolicy
  def create?
    user.is_a?(Producer) && amap && user.amaps.where(id: amap.id).exists?
  end

  def show?
    owner_of_formula?
  end

  def copy_formulas_delivery_days?
    return false unless manage_delivery_days?

    Formula.joins(:delivery_days)
           .where(producer_id: record.producer_id, period_id: record.period_id)
           .where.not(id: record.id)
           .exists?
  end

  def copy_formula_delivery_days?
    copy_formulas_delivery_days?
  end

  def manage_delivery_days?
    owner_of_formula?
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

  private

  def owner_of_formula?
    user.is_a?(Producer) && record.producer == user
  end
end
