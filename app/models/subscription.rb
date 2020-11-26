# frozen_string_literal: true

class Subscription < ApplicationRecord
  ALLOWED_TYPES = %w[Period Formula].freeze

  belongs_to :user
  belongs_to :subscribable, polymorphic: true

  monetize :price_cents, numericality: { greater_than_or_equal_to: 0 }

  validates :subscribable_id, uniqueness: { scope: %i[subscribable_type user_id] }
  validates :subscribable_type, inclusion: { in: ALLOWED_TYPES }

  validates :price_cents, presence: true

  scope :join_formulas, lambda {
    joins('INNER JOIN formulas ON formulas.id = subscriptions.subscribable_id')
      .where(subscribable_type: 'Formula')
  }

  scope :on_amap, lambda { |amap_or_id|
    id = case amap_or_id
         when ApplicationRecord then amap_or_id.id
         when Integer then amap_or_id
         else
           raise ArgumentError, 'argument must be an Amap or an ID'
         end

    joins(
      <<~SQL
        LEFT JOIN periods ON periods.id = subscribable_id AND subscribable_type = 'Period'
        LEFT JOIN formulas ON formulas.id = subscribable_id AND subscribable_type = 'Formula'
        LEFT JOIN periods periods_formulas ON periods_formulas.id = formulas.period_id
      SQL
    )
      .where('periods_formulas.amap_id = :amap_id OR periods.amap_id = :amap_id', amap_id: id)
  }

  def total_price
    price * quantity
  end
end
