class User < ApplicationRecord
  has_many :user_careers, dependent: :destroy
  has_many :careers, through: :user_careers

  has_many :employments, dependent: :destroy
  has_many :employers, through: :employments

  has_many :user_locations, dependent: :destroy
  has_many :locations, through: :user_locations
end