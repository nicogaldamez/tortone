class CoincidenceManager
  
  # Al crear un vehículo o un interesado, chequeo si hay coincidencias
  # Ej. CoincidenceManager.new(vehicle)
  def self.call(vehicle: false, buyer: false)
    coincidences_for_vehicle(vehicle) if vehicle?
    coincidences_for_buyer(buyer) if buyer?
  end
  
  
  private
  
  def coincidences_for_vehicle(vehicle)
    buyers = BuyerFinder.new(vehicle).call
    buyers.each { |buyer| build_coincidence(buyer, vehicle) }
  end
  
  def find_vehicles_for_buyer(buyer)
    vehicles = VehicleFinder.new(buyer).call
    vehicles.each { |vehicle| build_coincidence(buyer, vehicle) }
  end
  
  
  def build_coincidence(buyer, vehicle)
    Coincidence.create(
        buyer: buyer, 
        vehicle_model: vehicle.vehicle_model, 
        brand: vehicle.brand
    )
  end
end