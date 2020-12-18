# frozen_string_literal: true

class AddCashedOnToCheque < ActiveRecord::Migration[6.0]
  def change
    add_column :cheques, :cashed_on, :date
  end
end
