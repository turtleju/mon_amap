# frozen_string_literal: true

class CreateCheques < ActiveRecord::Migration[6.0]
  def change
    create_table :cheques do |t|
      t.references :payment, null: false
      t.references :producer, null: true
      t.monetize :price, currency: { present: false }
      t.string :status
      t.string :recipient
      t.date :cashing_on

      t.timestamps
    end
  end
end
