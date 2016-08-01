class VehicleFinder
  
  def initialize(buyer)
    @buyer = buyer
  end
  
  # Returns a collection of vehicles interesting for the buyer
  # Example: VehicleFinder.new(buyer).call
  def call
    vehicles = @buyer.buyer_interests.flat_map do |interest|
      coincident_vehicles(interest)
    end
    
    vehicles
  end
    
    
  private
  
  def coincident_vehicles(interest)
    buyer = interest.buyer
    
    vehicle_model              = interest.vehicle_model
    min_year, max_year         = years_range(interest.year)
    max_km                     = interest.max_kilometers || Float::INFINITY
    max_price                  = price(buyer.max_price)
    is_hdi                     = buyer.is_hdi?
    has_automatic_transmission = buyer.has_automatic_transmission?

    vehicles = Vehicle.not_sold
    vehicles = vehicles.where(
      vehicle_model: vehicle_model,
      year: (min_year..max_year),
      kilometers: (0..max_km),
      is_hdi: is_hdi,
      has_automatic_transmission: has_automatic_transmission,
      price_in_cents: [(0..max_price), nil]
    )
    
    vehicles
  end
  
  def years_range(year)
    min_year = year - Const::YEAR
    max_year = year + Const::YEAR
    
    return min_year, max_year
  end
  
  # Para usarlo en la query tengo que convertirlo a centavos ya que
  # en la DB está guardado como price_in_cents
  def price(price)
    price.to_i * 10_000
  end

end