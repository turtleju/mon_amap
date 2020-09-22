# frozen_string_literal: true

class CreateFormulas < ActiveRecord::Migration[6.0]
  def change
    create_table :formulas do |t|
      t.string :name
      t.string :category
      t.text :description
      t.references :producer, null: false, foreign_key: true
      t.references :period, null: false, foreign_key: true
      t.monetize :price, currency: { present: false }

      t.timestamps
    end
  end
end
