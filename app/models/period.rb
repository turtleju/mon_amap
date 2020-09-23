# frozen_string_literal: true

class Period < ApplicationRecord
  belongs_to :amap
  has_many   :formulas
  has_many   :period_days
  has_many   :subscriptions, as: :subscribable

  validates :start_on, presence: true
  validates :finish_on, presence: true

  validate :check_consistency_dates

  private

  def check_consistency_dates
    return unless start_on && finish_on

    errors.add(:finish_on, :unconsistency_dates) if finish_on <= start_on
  end
end
