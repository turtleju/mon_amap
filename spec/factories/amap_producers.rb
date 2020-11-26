# frozen_string_literal: true

FactoryBot.define do
  factory :amap_producer do
    producer { create(:producer) }
  end
end
