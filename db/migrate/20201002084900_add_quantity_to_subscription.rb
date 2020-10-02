# frozen_string_literal: true

class AddQuantityToSubscription < ActiveRecord::Migration[6.0]
  def change
    add_column :subscriptions, :quantity, :integer, default: 1
  end
end
