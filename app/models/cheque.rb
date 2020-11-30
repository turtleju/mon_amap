# frozen_string_literal: true

class Cheque < ApplicationRecord
  belongs_to :payment
  belongs_to :producer, optional: true
  monetize :price_cents, numericality: { greater_than_or_equal_to: 0 }

  scope :undeposited, -> { where(status: :init) }
end
