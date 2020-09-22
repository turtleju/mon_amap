# frozen_string_literal: true

class Producer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable, :registerable
  devise :database_authenticatable,
         :confirmable, :recoverable, :rememberable, :validatable

  has_many :formulas
end
