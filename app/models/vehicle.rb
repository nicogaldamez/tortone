class Vehicle < ActiveRecord::Base

  # -- Scopes
  default_scope -> { order(:created_at) }

  # -- Associations
  belongs_to :brand
  belongs_to :version
  belongs_to :vehicle_model
  belongs_to :customer
  has_many :attachments, dependent: :destroy
  has_many :budgets, dependent: :destroy
  has_one :sale, dependent: :destroy

  # -- Validations
  validates :brand, presence: true
  validates :vehicle_model, presence: true
  validates :version, presence: true
  validates :customer, presence: true, if: :not_owner?
  # validates :entered_on, presence: true, if: :is_owner?
  validates :year, presence: true
  validates :kilometers, presence: true
  validates :color, presence: true
  validates :year, presence: true
  validates :plate, uniqueness: true, allow_blank: true

  # -- Misc
  def not_owner?
    !is_owner?
  end

  # Para usar field_in_cents, etc.
  def self.attributes_in_cents
    ['cost', 'price', 'minimum_advance', 'transfer_amount']
  end

  include IntegerInCents

end
