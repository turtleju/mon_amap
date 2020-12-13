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

  scope :on_period, lambda { |period|
                      join_sql = <<~SQL
                        LEFT JOIN formulas
                        ON formulas.id = subscriptions.subscribable_id
                        AND subscriptions.subscribable_type = 'Formula'
                      SQL
                      where_sql = <<~SQL
                        (subscriptions.subscribable_type = 'Formula' AND formulas.period_id = :period_id)
                        OR
                        (subscriptions.subscribable_type = 'Period' AND subscriptions.subscribable_id = :period_id)
                      SQL
                      joins(join_sql).where(where_sql, period_id: period.id)
                    }

  scope :on_other_period, lambda { |period|
                            join_sql = <<~SQL
                              LEFT JOIN formulas
                              ON formulas.id = subscriptions.subscribable_id
                              AND subscriptions.subscribable_type = 'Formula'
                            SQL
                            where_sql = <<~SQL
                              (subscriptions.subscribable_type = 'Formula' AND formulas.period_id <> :period_id)
                              OR
                              (subscriptions.subscribable_type = 'Period' AND subscriptions.subscribable_id <> :period_id)
                            SQL
                            joins(join_sql).where(where_sql, period_id: period.id)
                          }

  def total_price
    price * quantity
  end
end
