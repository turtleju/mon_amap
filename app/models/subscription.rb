# frozen_string_literal: true

class Subscription < ApplicationRecord
  ALLOWED_TYPES = %w[Period Formula].freeze

  belongs_to :user
  belongs_to :subscribable, polymorphic: true

  monetize :price_cents, numericality: { greater_than_or_equal_to: 0 }

  validates :subscribable_id, uniqueness: { scope: %i[subscribable_type user_id] }
  validates :subscribable_type, inclusion: { in: ALLOWED_TYPES }

  validates :price_cents, presence: true
end
