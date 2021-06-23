class UserCareer < ApplicationRecord
  belongs_to :user
  belongs_to :career

  has_many :employments

  delegate :title, to: :career
end