# frozen_string_literal: true

class CreateDeliveryDays < ActiveRecord::Migration[6.0]
  def change
    create_table :delivery_days do |t|
      t.references :period_day, null: false, foreign_key: false
      t.references :formula, null: false, foreign_key: false

      t.timestamps
    end
  end
end
