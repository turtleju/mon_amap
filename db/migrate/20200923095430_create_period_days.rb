# frozen_string_literal: true

class CreatePeriodDays < ActiveRecord::Migration[6.0]
  def change
    create_table :period_days do |t|
      t.references :period, null: false, foreign_key: false
      t.date :day

      t.timestamps
    end
  end
end
