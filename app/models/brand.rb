class Brand < ActiveRecord::Base

  # -- Scopes
  default_scope -> { order(:name) }

  # -- Associations
  has_many :vehicles
  has_many :vehicle_models, dependent: :destroy

  # -- Methods
  def to_s
    name
  end
end
