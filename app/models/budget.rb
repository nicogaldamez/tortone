class Budget < ActiveRecord::Base

  # -- Associations
  belongs_to :vehicle

  # -- Validations
  validates :vehicle_description, presence: true
  validates :price, presence: true
  validates :budgeted_on, presence: true

  # Para usar field_in_cents, etc.
  def self.attributes_in_cents
    ['price']
  end

  include IntegerInCents

end
