# frozen_string_literal: true

FactoryBot.define do
  factory :amap do
    sequence(:name) { |n| "name#{n}" }
    sequence(:subdomain) { 'curis' }
    legal_address { 'Curis' }
    distribution_address { 'Curis' }
    latitude { 45.8734447 }
    longitude { 4.8209653 }
    description { 'Lorem, ipsum dolor sit, amet consectetur adipisicing elit. Laudantium quaerat sunt, debitis alias veniam facere. Labore, totam sunt numquam accusantium ratione rem excepturi consequatur qui suscipit. Vitae repudiandae, magnam modi.' }
    distribution_day { WEEK_DAYS.sample }
  end

  trait :with_manager do
    manager { create(:user) }
  end

  trait :with_producer do
    after(:create) { |amap| create(:amap_producer, amap: amap) }
  end
end
