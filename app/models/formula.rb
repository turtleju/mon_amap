# frozen_string_literal: true

class Formula < ApplicationRecord
  belongs_to :producer
  belongs_to :period

  monetize :price_cents, numericality: { greater_than_or_equal_to: 0 }

  validates :name, presence: true
  validates :name, uniqueness: { case_sensitive: false, scope: :producer }
  validates :category, presence: true
  validates :category, inclusion: { in: CATEGORIES }
  validates :description, presence: true
  validates :price_cents, presence: true
end
