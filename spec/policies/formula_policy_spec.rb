# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FormulaPolicy, type: :policy do
  let(:amap) { create(:amap, :with_manager, :with_producer) }
  let(:period) { create(:period, amap: amap) }
  let(:formula) { build(:formula, period: period) }

  subject { described_class.new({ user: user, amap: amap }, formula) }

  describe '#create?' do
    context 'when producer' do
      context 'belongs to the amap' do
        let(:user) { amap.producers.first }
        it { is_expected.to permit_action(:create) }
      end
      context 'not belongs to the amap' do
        let(:user) { create(:producer) }
        it { is_expected.to forbid_action(:create) }
      end
    end

    context 'when user' do
      let(:user) { amap.manager }
      it { is_expected.to forbid_action(:create) }
    end
  end

  describe '#show?' do
    it 'TODO'
  end

  describe '#manage_delivery_days?' do
    it 'TODO'
  end
end
