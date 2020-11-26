# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CreatePeriod do
  let(:start_on) { '2020-09-05' }
  let(:finish_on) { '2020-10-19' }

  let(:params_period) do
    {
      start_on: start_on,
      finish_on: finish_on
    }
  end

  describe '#initialize' do
    subject { described_class.new(params_period) }

    it 'set @params_period' do
      object = subject
      expect(object.instance_variable_get(:@params_period)).to eq(params_period)
    end
  end

  describe '#call' do
    before do
      Amap.current.update!(distribution_day: 'tuesday')
    end

    let!(:period) { described_class.call(params_period) }

    context 'when days before' do
      let(:start_on) { '2020-10-05' }
      let(:finish_on) { '2020-10-19' }
      let(:expected) { %w[2020-10-06 2020-10-13].map(&:to_date) }

      it do
        expect(period.period_days.pluck(:day)).to eq(expected)
      end
    end

    context 'when days on' do
      let(:start_on) { '2020-10-06' }
      let(:finish_on) { '2020-10-20' }
      let(:expected) { %w[2020-10-06 2020-10-13 2020-10-20].map(&:to_date) }

      it do
        expect(period.period_days.pluck(:day)).to eq(expected)
      end
    end
    context 'when days after' do
      let(:start_on) { '2020-10-07' }
      let(:finish_on) { '2020-10-21' }
      let(:expected) { %w[2020-10-13 2020-10-20].map(&:to_date) }

      it do
        expect(period.period_days.pluck(:day)).to eq(expected)
      end
    end
  end
end
