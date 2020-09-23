# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PeriodDay, type: :model do
  describe 'associations' do
    it { should belong_to(:period) }
  end

  describe 'validations' do
    subject { create(:period_day) }
    it { should validate_uniqueness_of(:day).scoped_to(:period_id) }
    it { should validate_presence_of(:day) }

    describe '#check_day_in_period' do
      let(:first_day) { '2020-01-01'.to_date }
      let(:last_day) { '2020-01-31'.to_date }
      let(:period) { create(:period, start_on: first_day, finish_on: last_day) }

      subject { PeriodDay.new(day: day, period: period) }

      context 'when first day period' do
        let(:day) { first_day }
        it { is_expected.to be_valid }
      end

      context 'when last day period' do
        let(:day) { last_day }
        it { is_expected.to be_valid }
      end

      context 'when middle of period' do
        let(:day) { '2020-01-15' }
        it { is_expected.to be_valid }
      end

      context 'when day before period' do
        let(:day) { first_day - 1 }
        it do
          is_expected.to_not be_valid
          expect(subject.errors.messages[:day]).to eq [I18n.t('activerecord.errors.models.period_day.attributes.day.unconsistency_day')] # rubocop:disable Layout/LineLength
        end
      end

      context 'when day after period' do
        let(:day) { last_day + 1 }
        it do
          is_expected.to_not be_valid
          expect(subject.errors.messages[:day]).to eq [I18n.t('activerecord.errors.models.period_day.attributes.day.unconsistency_day')] # rubocop:disable Layout/LineLength
        end
      end
    end
  end
end
