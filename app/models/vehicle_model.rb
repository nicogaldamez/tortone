class VehicleModel < ActiveRecord::Base

  # -- Associations
  has_many :vehicles
  has_many :versions
  belongs_to :brand

  # -- Validations
  validates :brand, presence: true

  # -- Methods
  def to_s
    name
  end
end
