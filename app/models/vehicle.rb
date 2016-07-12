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
  validates :customer, presence: true
  validates :entered_on, presence: true
  validates :color, presence: true

  # -- Misc
  def self.attributes_in_cents
    ['cost', 'price', 'minimum_advance', 'transfer_amount']
  end

  include IntegerInCents

end
