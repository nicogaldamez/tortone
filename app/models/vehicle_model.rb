class VehicleModel < ActiveRecord::Base

  # Scopes
  default_scope -> { order(:name) }

  # -- Associations
  has_many :vehicles
  has_many :versions, dependent: :destroy
  belongs_to :brand

  # -- Validations
  validates :brand, presence: true

  # -- Methods
  def to_s
    name
  end
end
