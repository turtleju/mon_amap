# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProducerPolicy, type: :policy do
  let(:amap) { create(:amap, :with_manager) }
  let(:amap2) { create(:amap, :with_manager) }

  subject { described_class.new({ user: user, amap: amap }, amap) }

  describe '#invitation?' do
    context 'when manager of amap' do
      let(:user) { amap.manager }

      it { is_expected.to permit_action(:invitation) }
    end

    context 'when not manager amap' do
      let(:user) { amap2.manager }

      it { is_expected.to forbid_action(:invitation) }
    end
  end
end
