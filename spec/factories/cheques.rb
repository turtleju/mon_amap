# frozen_string_literal: true

FactoryBot.define do
  factory :cheque do
    payment { nil }
    price { '' }
    status { 'MyString' }
    cashing_on { '2020-11-26' }
  end
end
