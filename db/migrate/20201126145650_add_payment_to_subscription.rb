# frozen_string_literal: true

class AddPaymentToSubscription < ActiveRecord::Migration[6.0]
  def change
    add_reference :subscriptions, :payment, null: true, foreign_key: true
  end
end
