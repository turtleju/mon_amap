# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Subscription, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:subscribable) }
  end

  describe 'validations' do
    subject { create(:subscription) }
    it { should validate_uniqueness_of(:subscribable_id).scoped_to(%i[subscribable_type user_id]) }
    it { should validate_presence_of(:price_cents) }
    it { should validate_numericality_of(:price_cents) }
  end
end
