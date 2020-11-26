# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProducerPolicy, type: :policy do
  let(:producer) { Producer.new }

  subject { described_class.new({ user: user }, producer) }

  describe '#invitation?' do
    context 'when manager of amap' do
      let(:user) { Amap.current.manager }

      it { is_expected.to permit_action(:invitation) }
    end

    context 'when not manager amap' do
      let(:user) { create(:user) }

      it { is_expected.to forbid_action(:invitation) }
    end
  end
end
