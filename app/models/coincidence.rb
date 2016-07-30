# == Schema Information
#
# Table name: coincidences
#
#  id               :integer          not null, primary key
#  buyer_id         :integer
#  vehicle_model_id :integer
#  brand_id         :integer
#  is_ignored       :boolean          default(FALSE)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Coincidence < ActiveRecord::Base
  
  # - Associations
  belongs_to :buyer
  belongs_to :vehicle
  
  # - Validations
  validates :buyer, presence: true
  validates :vehicle, presence: true
  validates :buyer, uniqueness: { scope: :vehicle }
  
  # - Scopes
  
  # - Methods
end
