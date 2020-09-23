# frozen_string_literal: true

FactoryBot.define do
  factory :period_day do
    period { create(:period, start_on: Date.today, finish_on: 6.months.from_now) }
    day { 1.day.from_now }
  end
end
