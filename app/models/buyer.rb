# == Schema Information
#
# Table name: buyers
#
#  id                         :integer          not null, primary key
#  first_name                 :string           not null
#  last_name                  :string
#  phones                     :string           not null
#  email                      :string
#  is_hdi                     :boolean          default(FALSE)
#  has_automatic_transmission :boolean          default(FALSE)
#  max_price_in_cents         :integer
#  notes                      :text
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#

class Buyer < ActiveRecord::Base
  
  # -- Scopes
  default_scope -> { order('created_at DESC') }

  # -- Associations
  has_many :buyer_interests, dependent: :destroy
  has_many :coincidences, dependent: :destroy
  accepts_nested_attributes_for :buyer_interests, allow_destroy: true

  # -- Validations
  validates :first_name, presence: true
  validates :max_price, presence: true
  validates :phones, presence: true

  # Para usar field_in_cents, etc.
  def self.attributes_in_cents
    ['max_price']
  end

  include IntegerInCents

  def last_name=(s)
    s.nil? ? super(s) : super(s.titleize)
  end

  def first_name=(s)
    s.nil? ? super(s) : super(s.titleize)
  end

end
