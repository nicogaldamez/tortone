class Version < ActiveRecord::Base

  # Scopes
  default_scope -> { order(:name) }

  # Validations
  validates :vehicle_model, presence: true

  # -- Associations
  has_many :vehicles
  belongs_to :vehicle_model

  # -- Methods
  def to_s
    name
  end
end
