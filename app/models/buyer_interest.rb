# == Schema Information
#
# Table name: buyer_interests
#
#  id               :integer          not null, primary key
#  buyer_id         :integer
#  brand_id         :integer
#  vehicle_model_id :integer
#  year             :integer          not null
#  max_kilometers   :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class BuyerInterest < ActiveRecord::Base
  
  # -- Scopes
  scope :for_brand_and_model, -> (brand, model) { where(brand: brand, vehicle_model: model) }

  # -- Associations
  belongs_to :buyer
  belongs_to :brand
  belongs_to :vehicle_model

  # -- Validations
  validates :brand, presence: true
  validates :vehicle_model, presence: true
  validates :year, presence: true

end
