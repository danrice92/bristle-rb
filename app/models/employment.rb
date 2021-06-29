class Employment < ApplicationRecord
  belongs_to :user
  belongs_to :employer
  belongs_to :user_career

  delegate :career, to: :user_career
  delegate :locations, to: :employer
end