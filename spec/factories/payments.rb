# frozen_string_literal: true

FactoryBot.define do
  factory :payment do
    price { 12.20 }
    status { 'init' }
    user { create(:user) }
  end
end
