# == Schema Information
#
# Table name: vehicles
#
#  id                         :integer          not null, primary key
#  brand_id                   :integer
#  vehicle_model_id           :integer
#  version_id                 :integer
#  customer_id                :integer
#  kilometers                 :integer
#  color                      :string
#  details                    :text
#  cost_in_cents              :integer
#  price_in_cents             :integer
#  entered_on                 :date
#  sold_on                    :date
#  is_consignment             :boolean          default(FALSE)
#  is_financed                :boolean          default(FALSE)
#  minimum_advance_in_cents   :integer
#  transfer_amount_in_cents   :integer
#  plate                      :string
#  year                       :integer
#  motor_number               :string
#  chassis_number             :string
#  created_at                 :datetime
#  updated_at                 :datetime
#  is_owner                   :boolean          default(FALSE)
#  has_automatic_transmission :boolean          default(FALSE)
#  is_hdi                     :boolean          default(FALSE)
#

class Vehicle < ActiveRecord::Base

  # -- Scopes
  default_scope -> { order(:created_at) }
  scope :not_sold, -> {
    joins('LEFT JOIN sales on sales.vehicle_id = vehicles.id')
      .where('sales.id is NULL OR sales.sold_on IS NULL').distinct
  }

  # -- Associations
  belongs_to :brand
  belongs_to :version
  belongs_to :vehicle_model
  belongs_to :customer
  has_many :attachments, dependent: :destroy
  has_many :budgets, dependent: :destroy
  has_many :coincidences, dependent: :destroy
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
  validates :plate, uniqueness: true, allow_blank: true

  # -- Misc
  def not_owner?
    !is_owner?
  end
  
  def sold?
    sold_on.present?
  end

  # Para usar field_in_cents, etc.
  def self.attributes_in_cents
    ['cost', 'price', 'minimum_advance', 'transfer_amount']
  end

  include IntegerInCents

end
