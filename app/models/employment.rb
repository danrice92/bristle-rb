class Employment < ApplicationRecord
  belongs_to :user
  belongs_to :employer
  belongs_to :user_career

  has_many :employment_locations
  has_many :locations, through: :employment_locations

  delegate :career, to: :user_career
  delegate :name, to: :employer, prefix: true

  def primary_location
    if primary_location_id.present?
      @primary_location ||= Location.find_by_id(primary_location_id)
    elsif locations.present?
      @primary_location ||= locations.last
      set_primary_location!(@primary_location.id)
      @primary_location
    else
      nil
    end
  end

  def set_primary_location! id
    update_columns(primary_location_id: id)
  end
end