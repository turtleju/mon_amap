# frozen_string_literal: true

class CreatePeriod < ApplicationService
  def initialize(params_period, amap)
    @params_period = params_period
    @amap = amap
  end

  def call
    build_period
    attach_amap
    yield(@period) if block_given?
    save_period
    generate_period_days if @period.persisted?
    @period
  end

  private

  def build_period
    @period = Period.new(@params_period)
  end

  def attach_amap
    @period.amap = @amap
  end

  def save_period
    @period.save
    puts @period.errors.full_messages if ENV['DEBUG_ALL']
  end

  def generate_period_days
    method_select_day = "#{@amap.distribution_day}?"
    days = (@period.start_on..@period.finish_on).to_a.select { |d| d.send(method_select_day) }
    time_now = Time.now
    period_days_attributes = days.map do |day|
      {
        period_id: @period.id,
        day: day,
        created_at: time_now,
        updated_at: time_now
      }
    end
    PeriodDay.insert_all(period_days_attributes)
  end
end
