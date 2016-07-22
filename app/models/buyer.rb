class Buyer < ActiveRecord::Base

  # -- Validations
  validates :first_name, presence: true
  validates :min_price, presence: true
  validates :max_price, presence: true
  validates :phone, presence: true

  # Para usar field_in_cents, etc.
  def self.attributes_in_cents
    ['min_price', 'max_price']
  end

  include IntegerInCents

end
