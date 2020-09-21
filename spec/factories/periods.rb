# frozen_string_literal: true

FactoryBot.define do
  factory :period do
    start_on { Date.today }
    finish_on { 6.months.from_now }
    amap { create(:amap) }
  end
end
