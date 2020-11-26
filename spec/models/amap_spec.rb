# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Amap, type: :model do
  describe 'associations' do
    it { should belong_to(:manager).optional }
  end

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:subdomain) }
  it { should validate_presence_of(:legal_address) }
  it { should validate_presence_of(:distribution_address) }
  it { should validate_presence_of(:latitude) }
  it { should validate_presence_of(:longitude) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:distribution_day) }
  it { should validate_inclusion_of(:distribution_day).in_array(WEEK_DAYS) }
end
