class EmployerLocation < ApplicationRecord
  belongs_to :employer
  belongs_to :location
end