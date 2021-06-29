class Location < ApplicationRecord
  belongs_to :employment

  has_many :employer_locations
  has_many :employers, through: :employer_locations

  has_many :user_locations
  has_many :users, through: :user_locations
end