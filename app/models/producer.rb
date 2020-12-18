# frozen_string_literal: true

class Producer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable, :registerable
  devise :database_authenticatable,
         :confirmable, :recoverable, :rememberable, :validatable

  has_many :formulas
  has_many :cheques
  has_one :amap_producer

  def password_required?
    confirmed? ? super : false
  end

  def full_name
    "#{first_name.capitalize} #{last_name.upcase}"
  end

  def member?
    amap_producer.present?
  end

  # TODO
  def recipient
    full_name
  end
end
