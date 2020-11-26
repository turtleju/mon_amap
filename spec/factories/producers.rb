# frozen_string_literal: true

FactoryBot.define do
  factory :producer do
    sequence(:email) { |n| "email#{n}@example.com" }
    sequence(:first_name) { |n| "firstname_#{n}" }
    sequence(:last_name) { |n| "lastname_#{n}" }
    sequence(:company_name) { |n| "company#{n}" }
    phone { '0611223344' }
    description { 'Lorem, ipsum dolor sit, amet consectetur adipisicing elit. Laudantium quaerat sunt, debitis alias veniam facere. Labore, totam sunt numquam accusantium ratione rem excepturi consequatur qui suscipit. Vitae repudiandae, magnam modi.' }
    password { 'azerty' }

    transient do
      confirmed { true }
    end

    after(:build, &:skip_confirmation_notification!)
    after(:create) { |u, evaluator| u.confirm if evaluator.confirmed }

    trait :member do
      after(:create) { |producer| create(:amap_producer, producer: producer) }
    end
  end
end
