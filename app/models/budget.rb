# == Schema Information
#
# Table name: budgets
#
#  id                  :integer          not null, primary key
#  vehicle_id          :integer
#  vehicle_description :string
#  year                :integer
#  price_in_cents      :integer
#  minimum_advance     :integer
#  financed            :string           default("0")
#  installments        :string           default("0")
#  installments_cost   :string           default("0")
#  expenses            :string           default("0")
#  notes               :string
#  budgeted_on         :date
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

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
