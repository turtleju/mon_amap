# frozen_string_literal: true

class AddManagerToAmap < ActiveRecord::Migration[6.0]
  def change
    add_reference :amaps, :manager, null: true, foreign_key: { to_table: :users }
  end
end
