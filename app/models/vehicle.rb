class Vehicle < ActiveRecord::Base

  # -- Scopes
  default_scope -> { order(:created_at) }

  # -- Associations
  belongs_to :brand
  belongs_to :version
  belongs_to :vehicle_model
  belongs_to :customer

  # -- Validations
  validates :brand, presence: true
  validates :vehicle_model, presence: true
  validates :version, presence: true
  validates :customer, presence: true
  validates :year, presence: true
  validates :kilometers, presence: true
  validates :color, presence: true
  validates :year, presence: true

  # -- Misc
  def self.attributes_in_cents
    ['cost', 'price', 'minimum_advance', 'transfer_amount']
  end

  include IntegerInCents

end
