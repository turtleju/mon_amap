# frozen_string_literal: true

class CreateAmaps < ActiveRecord::Migration[6.0]
  def change
    create_table :amaps do |t|
      t.string :name
      t.string :subdomain
      t.string :legal_address
      t.string :distribution_address
      t.float :latitude
      t.float :longitude
      t.text :description

      t.timestamps
    end
  end
end
