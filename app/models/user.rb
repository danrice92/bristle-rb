class User < ApplicationRecord
  has_many :user_careers, dependent: :destroy
  has_many :careers, through: :user_careers

  has_many :employments, dependent: :destroy
  has_many :employers, through: :employments

  has_many :user_locations, dependent: :destroy
  has_many :locations, through: :user_locations

  validates_presence_of :email
  validate :email
  validates :email, format: {
    with: /\A[\w\+\-\.]+@([\w\+\-\.]+\.[\w\+\-\.]+)+\z/,
    message: "must be a valid email address"
  }
end