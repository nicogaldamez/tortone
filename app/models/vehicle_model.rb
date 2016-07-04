class VehicleModel < ActiveRecord::Base
  
  # -- Associations
  has_many :vehicles
  belongs_to :brand
end