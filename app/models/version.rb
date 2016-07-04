class Version < ActiveRecord::Base

  # -- Associations
  has_many :vehicles
end