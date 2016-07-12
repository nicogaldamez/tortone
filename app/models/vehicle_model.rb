class VehicleModel < ActiveRecord::Base

  # -- Associations
  has_many :vehicles
  belongs_to :brand

  # -- Methods
  def to_s
    name
  end
end
