# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FormulaPolicy, type: :policy do
  let(:amap) { create(:amap, :with_manager, :with_producer) }
  let(:period) { create(:period, amap: amap) }
  let(:formula) { build(:formula, period: period) }
  let(:user) { nil }
  let(:producer) { nil }

  subject { described_class.new({ user: user, producer: producer, amap: amap }, formula) }

  describe '#create?' do
    context 'when producer' do
      context 'belongs to the amap' do
        let(:producer) { amap.producers.first }
        it { is_expected.to permit_action(:create) }
      end
      context 'not belongs to the amap' do
        let(:producer) { create(:producer) }
        it { is_expected.to forbid_action(:create) }
      end
    end

    context 'when user' do
      let(:user) { amap.manager }
      it { is_expected.to forbid_action(:create) }
    end
  end

  describe '#show?' do
    it 'allow when user is owner of formula' do
      allow_any_instance_of(described_class).to receive(:owner_of_formula?).and_return(true)
      is_expected.to permit_action(:show)
    end
    it 'forbid when user is not owner of formula' do
      allow_any_instance_of(described_class).to receive(:owner_of_formula?).and_return(false)
      is_expected.to forbid_action(:show)
    end
  end

  describe '#owner_of_formula?' do
    context 'when producer is owner of formula' do
      let(:producer) { formula.producer }
      it { is_expected.to permit_action(:show) }
    end

    context 'when user is not a Producteur' do
      let(:user) { create(:user) }
      it { is_expected.to forbid_action(:show) }
    end

    context 'when producer is not ower of formula' do
      let(:producer) { create(:producer) }
      it { is_expected.to forbid_action(:show) }
    end
  end

  describe '#manage_delivery_days?' do
    it 'allow when user is owner of formula' do
      allow_any_instance_of(described_class).to receive(:owner_of_formula?).and_return(true)
      is_expected.to permit_action(:show)
    end
    it 'forbid when user is not owner of formula' do
      allow_any_instance_of(described_class).to receive(:owner_of_formula?).and_return(false)
      is_expected.to forbid_action(:show)
    end
  end

  describe '#copy_formulas_delivery_days?' do
    let(:producer) { formula.producer }
    let(:previous_formula) { create(:formula, producer: formula.producer, period: formula.period) }

    it 'permit copy_formulas_delivery_days when previous formula with delivery_day on same period' do
      create(:delivery_day, formula: previous_formula, period_day: create(:period_day, period: formula.period))
      is_expected.to permit_action(:copy_formulas_delivery_days)
    end

    it { is_expected.to forbid_action(:copy_formulas_delivery_days) }
  end

  describe '#copy_formula_delivery_days?' do
    it 'when copy_formulas_delivery_days? is true' do
      allow_any_instance_of(described_class).to receive(:copy_formulas_delivery_days?).and_return(true)
      is_expected.to permit_action(:copy_formula_delivery_days)
    end
    it 'when copy_formulas_delivery_days? is false' do
      allow_any_instance_of(described_class).to receive(:copy_formulas_delivery_days?).and_return(false)
      is_expected.to forbid_action(:copy_formula_delivery_days)
    end
  end
end
