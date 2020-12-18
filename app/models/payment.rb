# frozen_string_literal: true

class Payment < ApplicationRecord
  STATUS_CONFIRMED = :confirmed
  STATUS_PENDING = :pending

  has_many :subscriptions
  has_many :cheques
  belongs_to :user

  monetize :price_cents, numericality: { greater_than_or_equal_to: 0 }

  def confirm!
    update(status: STATUS_CONFIRMED)
  end
end
