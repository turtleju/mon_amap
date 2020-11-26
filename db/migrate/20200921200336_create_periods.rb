# frozen_string_literal: true

class CreatePeriods < ActiveRecord::Migration[6.0]
  def change
    create_table :periods do |t|
      t.date :start_on
      t.date :finish_on

      t.timestamps
    end
  end
end
