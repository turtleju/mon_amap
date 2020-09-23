# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DeliveryDay, type: :model do
  describe 'associations' do
    it { should belong_to(:period_day) }
    it { should belong_to(:formula) }
  end

  describe 'validations' do
    subject { create(:delivery_day) }
    it { should validate_uniqueness_of(:period_day).scoped_to(:formula_id) }
  end
end
