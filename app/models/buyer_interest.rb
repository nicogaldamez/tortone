class BuyerInterest < ActiveRecord::Base

  # -- Associations
  belongs_to :buyer
  belongs_to :brand
  belongs_to :vehicle_model

  # -- Validations
  validates :brand, presence: true
  validates :vehicle_model, presence: true
  validates :year, presence: true

end
