class Location < ApplicationRecord
  has_many :employment_locations
  has_many :employments, through: :employment_locations

  has_many :employer_locations
  has_many :employers, through: :employer_locations

  has_many :user_locations
  has_many :users, through: :user_locations
end