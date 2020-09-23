# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Producer, type: :model do
  describe 'associations' do
    it { should have_many(:formulas) }
    it { should have_many(:amap_producers) }
    it { should have_many(:amaps) }
  end
end
