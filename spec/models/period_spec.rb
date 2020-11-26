# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Period, type: :model do
  describe 'associations' do
    it { should have_many(:formulas) }
    it { should have_many(:period_days) }
    it { should have_many(:subscriptions) }
  end

  describe 'validations' do
    it { should validate_presence_of(:start_on) }
    it { should validate_presence_of(:finish_on) }

    it 'should validate consistency between date' do
      period = build(:period, start_on: 10.years.from_now)
      expect(period).to_not be_valid
      expect(period.errors.messages[:finish_on]).to eq [I18n.t('activerecord.errors.models.period.attributes.finish_on.unconsistency_dates')] # rubocop:disable Layout/LineLength
    end
  end

  describe '.current and .next' do
    let!(:first_period) { create(:period, start_on: 10.days.ago, finish_on: 5.days.ago) }
    let!(:second_period) { create(:period, start_on: 4.days.ago, finish_on: 4.days.from_now) }
    let!(:third_period) { create(:period, start_on: 5.days.from_now, finish_on: 10.days.from_now) }
    let!(:fourth_period) { create(:period, start_on: 11.days.from_now, finish_on: 20.days.from_now) }

    it '.current should returns the second' do
      expect(Period.current).to eq(second_period)
    end

    it '.next should returns the third' do
      expect(Period.next).to eq(third_period)
    end
  end
end
