# frozen_string_literal: true

class Producer::DashboardController < Producer::ApplicationController
  def home
    authorize(Amap.current, :producer_management?)
    @cheques_uncashed = policy_scope(Cheque).where.not(status: Cheque::STATUS_CASHED)
    @number_cheques_uncashed = @cheques_uncashed.count
    @cheques_uncashed_amount = Money.from_amount(@cheques_uncashed.sum(:price_cents).fdiv(100))
    @current_period = Period.current
    @next_period = Period.next
  end
end
