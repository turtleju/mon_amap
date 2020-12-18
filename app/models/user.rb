# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable

  has_many :managed_amaps, class_name: 'Amap', foreign_key: :manager_id
  has_many :subscriptions
  has_many :payments
  has_many :cheques, through: :payments

  def full_name
    return "#{first_name.capitalize} #{last_name.upcase}" if first_name.present? && last_name.present?

    email
  end
end
