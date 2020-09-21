# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Amap, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:subdomain) }
  it { should validate_presence_of(:legal_address) }
  it { should validate_presence_of(:distribution_address) }
  it { should validate_presence_of(:latitude) }
  it { should validate_presence_of(:longitude) }
  it { should validate_presence_of(:description) }
end
