class Vehicle < ActiveRecord::Base

  # -- Scopes
  default_scope -> { order(:created_at) }
  
  # -- Associations
  belongs_to :brand
  belongs_to :version
  belongs_to :vehicle_model
  belongs_to :customer
  
  # -- Validations
  # validates :brand_id, presence: true
  # validates :model_id, presence: true
  # validates :version_id, presence: true
  # validates :customer_id, presence: true
  # validates :entered_on, presence: true
  # validates :color, presence: true
  
  # -- Misc
  def self.attributes_in_cents
    ['cost', 'price', 'minimum_advance', 'transfer_amount']
  end
  
  include IntegerInCents

end
