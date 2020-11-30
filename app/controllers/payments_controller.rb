# frozen_string_literal: true

class PaymentsController < ApplicationController
  before_action :verify_params_frequency, only: :create
  before_action :set_round, only: :create
  before_action :set_payment, only: %i[show confirmed]

  def show; end

  def create
    authorize(Payment)
    @payment = CreatePaymentAndCheques.call(current_user, params[:frequency], @round)
    redirect_to confirmed_payment_path(@payment)
  end

  def confirmed; end

  private

  def verify_params_frequency
    raise 'params frequency incorrect' unless params[:frequency].in? %w[monthly annually]
  end

  def set_round
    @round = params[:round] == 'true'
  end

  def set_payment
    @payment = Payment.find(params[:id])
    authorize(@payment)
  end
end
