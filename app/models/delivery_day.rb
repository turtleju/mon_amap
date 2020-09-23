# frozen_string_literal: true

class DeliveryDay < ApplicationRecord
  belongs_to :period_day
  belongs_to :formula

  validates :period_day, uniqueness: { scope: :formula_id }
end
