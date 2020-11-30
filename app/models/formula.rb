# frozen_string_literal: true

class Formula < ApplicationRecord
  belongs_to :producer
  belongs_to :period
  has_many   :delivery_days
  has_many   :period_days, through: :delivery_days
  has_many   :subscriptions, as: :subscribable

  monetize :price_cents, numericality: { greater_than_or_equal_to: 0 }

  validates :name, presence: true
  validates :name, uniqueness: { case_sensitive: false, scope: %i[producer period] }
  validates :category, presence: true
  validates :category, inclusion: { in: CATEGORIES }
  validates :description, presence: true
  validates :price_cents, presence: true

  def total_price
    price * delivery_days.in_future.count
  end
end
