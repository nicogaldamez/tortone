class Sale < ActiveRecord::Base

  # -- Associations
  belongs_to :customer
  belongs_to :vehicle

  # -- Validations
  validates :customer, presence: true
  validates :vehicle, presence: true
  validates :price, presence: true
  validates :advance, presence: true

  # -- Misc
  enum status: { pending: 0, finished: 1  }



  # Para usar field_in_cents, etc.
  def self.attributes_in_cents
    ['price', 'advance']
  end

  include IntegerInCents


end
