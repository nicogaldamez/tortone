class VehicleModel < ActiveRecord::Base

  # Scopes
  default_scope -> { order(:name) }
  scope :search, ->(q) { where('name ilike ?', "%#{q}%") }
  scope :search_in_model_and_brand, ->(q) {
    joins(:brand)
    .where('vehicle_models.name ilike :q OR brands.name ilike :q', q: "%#{q}%")
  }

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
