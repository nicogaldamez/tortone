# == Schema Information
#
# Table name: sales
#
#  id               :integer          not null, primary key
#  sold_on          :date
#  customer_id      :integer
#  vehicle_id       :integer
#  advance_in_cents :integer          default(0)
#  status           :integer          default(0)
#  price_in_cents   :integer
#  notes            :text
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Sale < ActiveRecord::Base

  # -- Associations
  belongs_to :customer
  belongs_to :vehicle

  # -- Validations
  validates :customer, presence: true
  validates :vehicle, presence: true
  validates :price, presence: true
  validates :advance, presence: true
  validates :advance_delivered_on, presence: true

  # -- Misc
  enum status: { pending: 0, finished: 1  }

  # Para usar field_in_cents, etc.
  def self.attributes_in_cents
    ['price', 'advance', 'cash']
  end

  include IntegerInCents

  def sold?
    !sold_on.nil? && !sold_on.blank?
  end


end
