class Buyer < ActiveRecord::Base

  # -- Associations
  has_many :buyer_interests, dependent: :destroy
  accepts_nested_attributes_for :buyer_interests, allow_destroy: true

  # -- Validations
  validates :first_name, presence: true
  validates :min_price, presence: true
  validates :phones, presence: true

  # Para usar field_in_cents, etc.
  def self.attributes_in_cents
    ['min_price', 'max_price']
  end

  include IntegerInCents

  def last_name=(s)
    s.nil? ? super(s) : super(s.titleize)
  end

  def first_name=(s)
    s.nil? ? super(s) : super(s.titleize)
  end

end
