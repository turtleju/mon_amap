# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Period, type: :model do
  describe 'associations' do
    it { should belong_to(:amap) }
    it { should have_many(:formulas)  }
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
end
