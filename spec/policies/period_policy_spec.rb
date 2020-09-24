# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PeriodPolicy, type: :policy do
  let(:period) { Period.new }

  subject { described_class.new({ user: user, amap: amap }, period) }

  let(:amap) { create(:amap, :with_manager) }

  context 'when user is manager of amap' do
    let(:user) { amap.manager }

    it { is_expected.to permit_action(:create) }
  end

  context 'when lambda user' do
    let(:user) { create(:user) }

    it { is_expected.to forbid_action(:create) }
  end
end
