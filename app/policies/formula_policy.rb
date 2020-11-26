# frozen_string_literal: true

class FormulaPolicy < ApplicationPolicy
  def create?
    producer&.member?
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

  def add_cart?
    true
  end

  class Scope < Scope
    def resolve
      if producer
        scope.where({ producer_id: producer.id })
      else
        scope.all
      end
    end
  end

  private

  def owner_of_formula?
    record.producer == producer
  end
end
