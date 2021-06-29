class AddEmploymentReferenceToLocations < ActiveRecord::Migration[6.1]
  def change
    add_reference :locations, :employment, index: true
  end
end
