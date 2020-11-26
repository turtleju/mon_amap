# frozen_string_literal: true

class AmapProducer < ApplicationRecord
  belongs_to :producer

  validates :producer, uniqueness: true
end
