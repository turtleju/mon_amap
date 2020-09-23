# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Formula, type: :model do
  describe 'associations' do
    it { should belong_to(:producer) }
    it { should belong_to(:period) }
    it { should have_many(:period_days) }
    it { should have_many(:delivery_days) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:category) }
    it { should validate_inclusion_of(:category).in_array(CATEGORIES) }
    it { should validate_presence_of(:description) }

    it 'should validate uniqueness name scope by producer' do
      producer1 = create(:producer)
      producer2 = create(:producer)

      create(:formula, name: 'first_name', producer: producer1)

      formula1 = build(:formula, name: 'second_name', producer: producer1)
      formula2 = build(:formula, name: 'first_name', producer: producer2)
      formula3 = build(:formula, name: 'first_name', producer: producer1)

      expect(formula1).to be_valid
      expect(formula2).to be_valid
      expect(formula3).to_not be_valid

      expect(formula3.errors.messages[:name]).to eq [I18n.translate('errors.messages.taken')]
    end
  end
end
