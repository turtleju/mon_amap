# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AllocateSumByMonth do
  subject { described_class.call(period, sum) }

  let(:start_on)  { '2020-05-08' }
  let(:finish_on) { '2021-01-08' }
  let(:period)    { create(:period, start_on: start_on, finish_on: finish_on) }
  let(:sum)       { 1000 }
  let(:today)     { period.start_on }
  let(:dates) do
    %w[
      2020-05-08
      2020-06-08
      2020-07-08
      2020-08-08
      2020-09-08
      2020-10-08
      2020-11-08
      2020-12-08
    ].map(&:to_date)
  end

  before do
    allow(Date).to receive(:today).and_return today.to_date
  end
  it { is_expected.to be_an(Array) }

  context 'when today is before the first day of the period' do
    let(:today) { period.start_on - 1 }
    it 'should be the first day of period that be the first day of payment' do
      expect(subject.first[:date]).to eq(period.start_on)
    end

    it 'sould total of subsum to be eqal of sum' do
      expect(subject.sum { |paiement| paiement[:sum] }).to eq(sum)
    end
  end

  context 'when today is the first day of the period' do
    let(:today) { period.start_on }
    it 'should be the first day of period that be the first day of payment' do
      expect(subject.first[:date]).to eq(period.start_on)
    end
    it 'sould total of subsum to be eqal of sum' do
      expect(subject.sum { |paiement| paiement[:sum] }).to eq(sum)
    end
  end

  context 'when period has already started' do
    let(:today) { '15-08-2020' }
    it 'should be today that be the first day of payment' do
      expect(subject.first[:date]).to eq(today.to_date)
    end
    it 'sould total of subsum to be eqal of sum' do
      expect(subject.sum { |paiement| paiement[:sum] }).to eq(sum)
    end
  end

  context 'when today is the last day of the period' do
    let(:today) { period.finish_on }
    it 'should be today that be the first day of payment' do
      expect(subject.first[:date]).to eq(today.to_date)
    end
    it 'sould total of subsum to be eqal of sum' do
      expect(subject.sum { |paiement| paiement[:sum] }).to eq(sum)
    end
  end

  context 'when today is after the last day of the period' do
    let(:today) { period.finish_on + 1 }
    it { expect { subject }.to raise_error(AllocateSumByMonth::InvalidPeriodDates) }
  end

  context 'when the extra of days is less than 7 days' do
    let(:start_on)  { '2020-05-02' }
    let(:dates) do
      %w[
        2020-05-02
        2020-06-08
        2020-07-08
        2020-08-08
        2020-09-08
        2020-10-08
        2020-11-08
        2020-12-08
      ].map(&:to_date)
    end

    it 'should merge the extra with the next period' do
      expect(subject.map { |payment| payment[:date] }).to eq(dates)
    end

    it 'sould total of subsum to be eqal of sum' do
      expect(subject.sum { |paiement| paiement[:sum] }).to eq(sum)
    end
  end

  context 'when the extra of days is more than 7 days' do
    let(:start_on)  { '2020-05-01' }
    let(:dates) do
      %w[
        2020-05-01
        2020-05-08
        2020-06-08
        2020-07-08
        2020-08-08
        2020-09-08
        2020-10-08
        2020-11-08
        2020-12-08
      ].map(&:to_date)
    end

    it 'should let this extra as a period itself' do
      expect(subject.map { |payment| payment[:date] }).to eq(dates)
    end

    it 'sould total of subsum to be eqal of sum' do
      expect(subject.sum { |paiement| paiement[:sum] }).to eq(sum)
    end
  end

  context 'when period is less than one month' do
    let(:start_on)  { '2020-05-08' }
    let(:finish_on) { '2020-05-25' }

    it 'sould return only one date when period is less than one month' do
      expect(subject.size).to eq(1)
    end
  end
end
