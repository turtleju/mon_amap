# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AmapProducer, type: :model do
  describe 'associations' do
    it { should belong_to(:producer) }
  end

  describe 'validations' do
    subject { create(:amap_producer) }
    it { should validate_uniqueness_of(:producer) }
  end
end
