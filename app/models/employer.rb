class Employer < ApplicationRecord
  has_many :employments
  has_many :users, through: :employments

  has_many :employer_locations, dependent: :destroy
  has_many :locations, through: :employer_locations
end