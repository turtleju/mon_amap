# frozen_string_literal: true

class CreateAmapProducers < ActiveRecord::Migration[6.0]
  def change
    create_table :amap_producers do |t|
      t.references :amap, null: false, foreign_key: true
      t.references :producer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
