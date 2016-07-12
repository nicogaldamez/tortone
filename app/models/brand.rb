class Brand < ActiveRecord::Base
  
  # -- Associations
  has_many :vehicles
  has_many :vehicle_models
  
  # -- Methods
  def to_s
    name
  end
end