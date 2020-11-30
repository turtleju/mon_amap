# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Formula, type: :model do
  describe 'associations' do
    it { should belong_to(:producer) }
    it { should belong_to(:period) }
    it { should have_many(:period_days) }
    it { should have_many(:delivery_days) }
    it { should have_many(:subscriptions) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:category) }
    it { should validate_inclusion_of(:category).in_array(CATEGORIES) }
    it { should validate_presence_of(:description) }

    it 'should validate uniqueness name scope by producer' do
      producer1 = create(:producer)
      producer2 = create(:producer)
      period1   = create(:period)
      period2   = create(:period)

      create(:formula, name: 'first_name', producer: producer1, period: period1)

      formula1 = build(:formula, name: 'second_name', producer: producer1, period: period1)
      formula2 = build(:formula, name: 'first_name', producer: producer2, period: period1)
      formula3 = build(:formula, name: 'first_name', producer: producer1, period: period2)
      formula4 = build(:formula, name: 'first_name', producer: producer1, period: period1)

      expect(formula1).to     be_valid
      expect(formula2).to     be_valid
      expect(formula3).to     be_valid
      expect(formula4).to_not be_valid

      expect(formula4.errors.messages[:name]).to eq [I18n.translate('errors.messages.taken')]
    end
  end
end
