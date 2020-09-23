# frozen_string_literal: true

class PeriodDay < ApplicationRecord
  belongs_to :period

  validates :day, presence: true
  validates :day, uniqueness: { scope: :period_id }

  validate :check_day_in_period

  private

  def check_day_in_period
    return unless day && period

    days = (period.start_on..period.finish_on)
    errors.add(:day, :unconsistency_day) unless day.in? days
  end
end