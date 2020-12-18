# frozen_string_literal: true

class Manager::ChequesController < Manager::ApplicationController
  def index
    @cheques = Cheque.all
  end

  def give_envelope_pick_producer
    @producers = Producer.joins(:cheques).where(cheques: { status: Cheque::STATUS_DEPOSIT_CONFIRMED }).distinct
  end

  def give_envelope_producer_select_payment
    @producer = Producer.find(params[:producer_id])
    @cheques_by_payment = @producer.cheques.where(status: Cheque::STATUS_DEPOSIT_CONFIRMED).group_by(&:payment_id)
    @cheques_by_payment.each do |payment_id, cheques|
      @cheques_by_payment[payment_id] = {
        user: User.joins(:payments).find_by(payments: { id: payment_id }),
        cheques: cheques
      }
    end
  end

  def give_envelope_producer
    @payment = Payment.find(params[:payment_id])
    @producer = Producer.find(params[:producer_id])

    Cheque.where(payment: @payment, producer: @producer).update_all(status: Cheque::STATUS_TRANSFERED_TO_PRODUCER)

    redirect_to give_envelope_producer_select_payment_manager_cheques_path(@producer), notice: t('.success')
  end
end
