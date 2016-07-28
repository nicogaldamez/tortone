class BuyerFinder
  
  def initialize(vehicle)
    @vehicle = vehicle
  end
  
  # Returns a collection of buyers interested in the @vehicle
  # Example: BuyerFinder.new(vehicle).call
  def call
    interests = BuyerInterest.for_brand_and_model(@vehicle.brand, @vehicle.vehicle_model)
    buyers = interests.collect do |interest|
      coincidence_result = CoincidenceFinder.new(vehicle: @vehicle, interest: interest).call
      interest.buyer if coincidence_result
    end
    
    buyers.uniq
  end

end