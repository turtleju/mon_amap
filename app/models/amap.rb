# frozen_string_literal: true

class Amap < ApplicationRecord
  belongs_to :manager, class_name: 'User', optional: true

  validates :name, presence: true
  validates :subdomain, presence: true
  validates :legal_address, presence: true
  validates :distribution_address, presence: true
  validates :latitude, presence: true
  validates :longitude, presence: true
  validates :description, presence: true
  validates :distribution_day, presence: true, inclusion: { in: WEEK_DAYS }

  def self.current
    find_by(subdomain: Apartment::Tenant.current)
  end
end
