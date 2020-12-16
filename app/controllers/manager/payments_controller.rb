# frozen_string_literal: true

class Manager::PaymentsController < Manager::ApplicationController
  def confirm_deposit_pick_user
    @users = User.joins(:payments).where(payments: { status: :pending }).distinct
  end

  def confirm_deposit_user
    @payments = User.find(params[:user_id]).payments.where(status: :pending)
  end

  def confirm_deposit
    @payment = Payment.find(params[:id])
    authorize(@payment)
    ValidatePayment.call(@payment)
    redirect_to manager_root_path, notice: t('.success')
  end
end
