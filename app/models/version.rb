class Version < ActiveRecord::Base

  # -- Associations
  has_many :vehicles
  
  # -- Methods
  def to_s
    name
  end
end