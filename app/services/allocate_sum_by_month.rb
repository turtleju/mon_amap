# frozen_string_literal: true

class AllocateSumByMonth < ApplicationService
  class InvalidPeriodDates < StandardError; end

  NUMBER_DAYS_TO_MERGE_PAIEMENTS = 7

  def initialize(period, sum, months_without_cents: false)
    @period              = period
    @sum                 = sum
    @months_without_cents = months_without_cents
    raise InvalidPeriodDates if Date.today > period.finish_on
  end

  def call
    generate_dates
    generate_sums

    @dates.map.with_index do |date, i|
      {
        date: date,
        sum: i.zero? ? @extra : @sum_per_month
      }
    end
  end

  private

  def first_day
    @first_day ||= find_first_day
  end

  def find_first_day
    Date.today > @period.start_on ? Date.today : @period.start_on
  end

  def generate_dates
    @dates = []
    date = @period.finish_on - 1.month
    while date > first_day
      @dates << date
      date -= 1.month
    end
    @dates << first_day
    @dates.reverse!
    merge_extra_period
  end

  # We want merge paiements, if dates of them are to close
  def merge_extra_period
    return unless @dates.size > 2
    return unless (@dates[1] - @dates[0]).to_i < NUMBER_DAYS_TO_MERGE_PAIEMENTS

    @dates.delete_at(1)
  end

  def generate_sums
    if @dates.size == 1
      @extra = @sum
      return
    end

    extra_should_be         = sum_per_day * (@dates[1] - @dates[0]).to_i
    rest_for_other_months   = @sum - extra_should_be
    nb_months               = @dates.size - 1
    diviser                 = @months_without_cents ? nb_months * 100 : nb_months
    extra_cents             = rest_for_other_months % diviser
    @extra                  = extra_should_be + extra_cents
    rest_for_other_months  -= extra_cents
    @sum_per_month          = rest_for_other_months / nb_months
  end

  def sum_per_day
    @sum_per_day ||= @sum / nb_days
  end

  def nb_days
    (@dates.last - @dates.first).to_i + 1
  end
end
