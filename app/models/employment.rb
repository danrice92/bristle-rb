class Employment < ApplicationRecord
  belongs_to :user
  belongs_to :employer
  belongs_to :user_career

  has_one :location

  delegate :career, to: :user_career
end