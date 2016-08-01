class CoincidenceFilter
  include ActiveModel::Model
  attr_accessor :vehicle_model

  def call
    coincidences = Coincidence.non_ignored
    
    coincidences
  end
end
