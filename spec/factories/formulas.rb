# frozen_string_literal: true

FactoryBot.define do
  factory :formula do
    producer { create(:producer) }
    period { create(:period) }
    sequence(:name) { |n| "name#{n}" }
    category { CATEGORIES.sample }
    description { 'formula description' }
  end
end
