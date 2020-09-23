# frozen_string_literal: true

class AmapProducer < ApplicationRecord
  belongs_to :amap
  belongs_to :producer

  validates :producer, uniqueness: { scope: :amap_id }
end
