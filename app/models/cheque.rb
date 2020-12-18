# frozen_string_literal: true

class Cheque < ApplicationRecord
  STATUS_INIT = :init
  STATUS_DEPOSITED = :deposited
  STATUS_DEPOSIT_CONFIRMED = :deposit_confirmed
  STATUS_TRANSFERED_TO_PRODUCER = :transfered_to_producer
  STATUS_CASHED = :cashed

  belongs_to :payment
  belongs_to :producer, optional: true
  monetize :price_cents, numericality: { greater_than_or_equal_to: 0 }

  scope :undeposited, -> { where(status: STATUS_INIT) }

  def cash(date)
    update(status: STATUS_CASHED, cashed_on: date)
  end

  def self.cash(date)
    update_all(status: STATUS_CASHED, cashed_on: date)
  end
end
