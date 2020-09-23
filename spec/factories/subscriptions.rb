# frozen_string_literal: true

FactoryBot.define do
  factory :subscription do
    user { create(:user) }
    subscribable { create(:period) }
    price { 22 }
  end
end
