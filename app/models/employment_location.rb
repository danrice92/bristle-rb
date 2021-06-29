class EmploymentLocation < ApplicationRecord
  belongs_to :employment
  belongs_to :location
end