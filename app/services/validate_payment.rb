# frozen_string_literal: true

class ValidatePayment < ApplicationService
  def initialize(payment)
    @payment = payment
  end

  def call
    validate_payment
    update_cheques_status
    # notification?
  end

  private

  def validate_payment
    @payment.confirm!
  end

  def update_cheques_status
    @payment.cheques.update_all(status: :deposit_confirmed)
  end
end
