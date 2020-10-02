# frozen_string_literal: true

class AddPriceToPeriod < ActiveRecord::Migration[6.0]
  def change
    add_monetize :periods, :price, currency: { present: false }
  end
end
