# frozen_string_literal: true

class CreatePaymentAndCheques < ApplicationService
  def initialize(user, frequency, round)
    @user      = user
    @frequency = frequency
    @round     = round
  end

  def call
    load_subscriptions
    detect_and_load_period_from_subscription
    create_payment
    generate_cheques_attributes
    add_cheque_period
    Cheque.create!(@cheques_attributes)
    @payment
  end

  private

  def load_subscriptions
    @subscriptions          = @user.subscriptions.without_payment
    @subscription_period    = @subscriptions.find_by(subscribable_type: 'Period')
    @subscriptions_grouped  = @subscriptions.where(subscribable_type: 'Formula')
                                            .group_by { |s| s.subscribable.producer }
  end

  def create_payment
    amount = @subscriptions.inject(0) { |sum, subscription| sum + subscription.price * subscription.quantity }
    @payment = Payment.create!(status: 'pending', price: amount, user: @user)
    @subscriptions.update_all(payment_id: @payment.id)
  end

  def generate_cheques_attributes
    case @frequency
    when 'monthly' then generate_cheques_attributes_monthly
    when 'annually' then generate_cheques_attributes_annually
    end
  end

  def generate_cheques_attributes_monthly
    @cheques_attributes = @subscriptions_grouped.map do |producer, subscriptions|
      amount = subscriptions.inject(0) { |sum, subscription| sum + subscription.price * subscription.quantity }
      AllocateSumByMonth.call(@period, amount.cents, months_without_cents: @round).map do |payment|
        {
          payment: @payment,
          producer: producer,
          status: 'init',
          recipient: producer.full_name,
          price: Money.from_amount(payment[:sum].fdiv(100)),
          cashing_on: payment[:date]
        }
      end
    end
  end

  def generate_cheques_attributes_annually
    @cheques_attributes = @subscriptions_grouped.map do |producer, subscriptions|
      amount = subscriptions.inject(0) { |sum, subscription| sum + subscription.price * subscription.quantity }
      {
        payment: @payment,
        producer: producer,
        status: 'init',
        recipient: producer.full_name,
        price: amount,
        cashing_on: @period.start_on > Date.today ? @period.start_on : Date.today
      }
    end
  end

  def add_cheque_period
    return unless @subscription_period

    @cheques_attributes << {
      payment: @payment,
      status: 'init',
      recipient: Amap.current.name,
      price: @subscription_period.price,
      cashing_on: @period.start_on > Date.today ? @period.start_on : Date.today
    }
  end

  # We acted to NOT manage the case where an user subscribed in the same cart to many periods items
  def detect_and_load_period_from_subscription
    periods = @subscriptions.all.map do |s|
      case s.subscribable
      when Formula then s.subscribable.period
      when Period then s.subscribable
      end
    end.uniq
    raise 'multiple periods in cart' if periods.size > 1

    @period = periods.first
  end
end
