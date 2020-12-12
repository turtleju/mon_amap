# frozen_string_literal: true

class Subscription < ApplicationRecord
  ALLOWED_TYPES = %w[Period Formula].freeze

  belongs_to :user
  belongs_to :subscribable, polymorphic: true
  belongs_to :payment, optional: true

  monetize :price_cents, numericality: { greater_than_or_equal_to: 0 }

  validates :subscribable_id, uniqueness: { scope: %i[subscribable_type user_id payment_id] }
  validates :subscribable_type, inclusion: { in: ALLOWED_TYPES }

  validates :price_cents, presence: true

  scope :join_formulas, lambda {
    joins('INNER JOIN formulas ON formulas.id = subscriptions.subscribable_id')
      .where(subscribable_type: 'Formula')
  }

  scope :without_payment, -> { where(payment_id: nil) }

  # scope :on_period, ->(period) {ap period ; all}

  def total_price
    price * quantity
  end
end
