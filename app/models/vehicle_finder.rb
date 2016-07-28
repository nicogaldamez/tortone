class VehicleFinder
  
  def initialize(buyer)
    @buyer = buyer
  end
  
  # Returns a collection of vehicles interesting for the buyer
  # Example: BuyerFinder.new(vehicle).call
  def call
    vehicles = @buyer.buyer_interests.flat_map do |interest|
      coincident_vehicles(interest)
    end
    
    vehicles
  end
    
    
  private
  
  def coincident_vehicles(interest)
    vehicles = Vehicle.from_brand_and_model(interest.brand, interest.vehicle_model)
    vehicles = vehicles.select do |vehicle|
      CoincidenceFinder.new(vehicle: vehicle, interest: interest).call
    end
    
    vehicles
  end

end