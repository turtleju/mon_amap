# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "email#{n}@example.com" }
    sequence(:first_name) { |n| "firstname_#{n}" }
    sequence(:last_name) { |n| "lastname_#{n}" }
    password { 'azerty' }

    transient do
      confirmed { true }
    end

    after(:build, &:skip_confirmation_notification!)
    after(:create) { |u, evaluator| u.confirm if evaluator.confirmed }
  end
end
