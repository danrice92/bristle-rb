class Employment < ApplicationRecord
  belongs_to :user
  belongs_to :employer
  belongs_to :user_career
end