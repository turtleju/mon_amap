# frozen_string_literal: true

FactoryBot.define do
  factory :amap_producer do
    amap { create(:amap) }
    producer { create(:producer) }
  end
end
