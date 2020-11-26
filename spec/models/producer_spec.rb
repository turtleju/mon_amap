# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Producer, type: :model do
  describe 'associations' do
    it { should have_many(:formulas) }
    it { should have_one(:amap_producer) }
  end
end
