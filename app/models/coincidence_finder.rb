class CoincidenceFinder

  # Al crear un vehículo o un interesado, chequeo si hay coincidencias
  # Ej. CoincidenceFinder.new(vehicle) o CoincidenceFinder.new(buyer)
  def self.call(vehicle: false, buyer: false)
    coincidences_for_vehicle(vehicle) if vehicle
    coincidences_for_buyer(buyer) if buyer
  end


  private

  def self.coincidences_for_vehicle(vehicle)
    buyers = BuyerFinder.new(vehicle).call

    Coincidence.where(vehicle: vehicle).delete_all
    if buyers.any?
      buyers.each { |buyer| create_coincidences(buyer, vehicle) }
    end
  end

  def self.coincidences_for_buyer(buyer)
    vehicles = VehicleFinder.new(buyer).call

    Coincidence.where(buyer: buyer).delete_all
    if vehicles.any?
      vehicles.each { |vehicle| create_coincidences(buyer, vehicle) }
    end
  end

  def self.create_coincidences(buyer, vehicle)
    Coincidence.create(buyer: buyer, vehicle: vehicle)
  end

end