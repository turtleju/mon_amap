# frozen_string_literal: true

class DeliveryDay < ApplicationRecord
  belongs_to :period_day
  belongs_to :formula

  validates :period_day, uniqueness: { scope: :formula_id }

  scope :in_future, -> { joins(:period_day).where('period_days.day >= CURRENT_DATE') }
end
