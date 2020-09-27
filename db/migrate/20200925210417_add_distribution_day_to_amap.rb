# frozen_string_literal: true

class AddDistributionDayToAmap < ActiveRecord::Migration[6.0]
  def change
    add_column :amaps, :distribution_day, :string
  end
end
