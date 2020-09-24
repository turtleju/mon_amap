# frozen_string_literal: true

class Producer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable, :registerable
  devise :database_authenticatable,
         :confirmable, :recoverable, :rememberable, :validatable

  has_many :formulas
  has_many :amap_producers
  has_many :amaps, through: :amap_producers

  def password_required?
    confirmed? ? super : false
  end
end
