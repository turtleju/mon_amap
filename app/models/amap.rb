# frozen_string_literal: true

class Amap < ApplicationRecord
  belongs_to  :manager, class_name: 'User', optional: true
  has_many    :periods
  has_one     :current_period, -> { where('CURRENT_DATE BETWEEN start_on AND finish_on') }, class_name: 'Period'
  has_one     :next_period, -> { where('start_on >= CURRENT_DATE') }, class_name: 'Period'
  has_many    :amap_producers
  has_many    :producers, through: :amap_producers

  validates :name, presence: true
  validates :subdomain, presence: true
  validates :legal_address, presence: true
  validates :distribution_address, presence: true
  validates :latitude, presence: true
  validates :longitude, presence: true
  validates :description, presence: true
  validates :distribution_day, presence: true, inclusion: { in: WEEK_DAYS }
end
