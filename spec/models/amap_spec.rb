# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Amap, type: :model do
  describe 'associations' do
    it { should have_many(:periods) }
    it { should have_many(:amap_producers) }
    it { should have_many(:producers) }
    it { should belong_to(:manager).optional }

    describe 'current_period' do
      let(:amap) { create(:amap) }
      let!(:first_period) { create(:period, amap: amap, start_on: 10.days.ago, finish_on: 5.days.ago) }
      let!(:second_period) { create(:period, amap: amap, start_on: 4.days.ago, finish_on: 4.days.from_now) }
      let!(:third_period) { create(:period, amap: amap, start_on: 5.days.ago, finish_on: 10.days.from_now) }

      it { should have_one(:current_period) }

      it 'should returns the current_period' do
        expect(amap.current_period).to eq(second_period)
      end
    end
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
