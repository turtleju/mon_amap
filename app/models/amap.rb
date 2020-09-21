# frozen_string_literal: true

class Amap < ApplicationRecord
  validates :name, presence: true
  validates :subdomain, presence: true
  validates :legal_address, presence: true
  validates :distribution_address, presence: true
  validates :latitude, presence: true
  validates :longitude, presence: true
  validates :description, presence: true
end
