# == Schema Information
#
# Table name: brands
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime
#  updated_at :datetime
#

class Brand < ActiveRecord::Base

  # -- Scopes
  default_scope -> { order(:name) }

  # -- Associations
  has_many :vehicles
  has_many :vehicle_models, dependent: :destroy

  # -- Validations
  validates :name, presence: true

  # -- Methods
  def to_s
    name
  end

  def name=(s)
    s.nil? ? super(s) : super(s.titleize)
  end
end
