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
  belongs_to :vehicle_model
  belongs_to :brand
  
  # - Scopes
  
  # - Methods
end
