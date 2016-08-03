# == Schema Information
#
# Table name: coincidences
#
#  id         :integer          not null, primary key
#  buyer_id   :integer
#  vehicle_id :integer
#  is_ignored :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Coincidence < ActiveRecord::Base
  
  default_scope -> { order(:is_ignored, :created_at) }
  
  # - Associations
  belongs_to :buyer
  belongs_to :vehicle
  
  # - Validations
  validates :buyer, presence: true
  validates :vehicle, presence: true
  validates :buyer, uniqueness: { scope: :vehicle }
  
  # - Scopes
  scope :non_ignored, -> { where(is_ignored: false) }
  
  # - Methods
end
