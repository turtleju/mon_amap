# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AmapPolicy, type: :policy do
  subject { described_class.new({ user: user, amap: nil }, amap) }

  let(:amap) { build(:amap) }

  context 'not being admin' do
    let(:user) { create(:user) }

    it { is_expected.to forbid_action(:create) }
  end

  context 'being admin' do
    let(:user) { create(:user, admin: true) }

    it { is_expected.to permit_action(:create) }
  end
end
