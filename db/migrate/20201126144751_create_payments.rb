# frozen_string_literal: true

class CreatePayments < ActiveRecord::Migration[6.0]
  def change
    create_table :payments do |t|
      t.monetize :price, currency: { present: false }
      t.string :status

      t.timestamps
    end
  end
end
