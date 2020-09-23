# frozen_string_literal: true

FactoryBot.define do
  factory :delivery_day do
    period_day { create(:period_day) }
    formula { create(:formula, period: period_day.period) }
  end
end
