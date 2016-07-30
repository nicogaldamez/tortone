# == Schema Information
#
# Table name: versions
#
#  id               :integer          not null, primary key
#  name             :string
#  created_at       :datetime
#  updated_at       :datetime
#  vehicle_model_id :integer
#

class Version < ActiveRecord::Base

  # Scopes
  default_scope -> { order(:name) }

  # Validations
  validates :vehicle_model, presence: true
  validates :name, presence: true

  # -- Associations
  has_many :vehicles
  belongs_to :vehicle_model

  # -- Methods
  def to_s
    name
  end

  def name=(s)
    s.nil? ? super(s) : super(s.titleize)
  end
end
