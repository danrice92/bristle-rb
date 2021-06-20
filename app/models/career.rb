class Career < ApplicationRecord
  has_many :user_careers
  has_many :users, through: :user_careers
end