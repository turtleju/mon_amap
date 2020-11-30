# frozen_string_literal: true

class AddUserToPayment < ActiveRecord::Migration[6.0]
  def change
    add_reference :payments, :user, null: false, foreign_key: false
  end
end
