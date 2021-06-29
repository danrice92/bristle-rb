class CreateEmploymentLocations < ActiveRecord::Migration[6.1]
  def change
    create_table :employment_locations do |t|
      t.belongs_to :employment, index: true
      t.belongs_to :location, index: true

      t.timestamps
    end

    add_column :employments, :primary_location_id, :integer, index: true
  end
end
