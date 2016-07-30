class BuyerFinder

  def initialize(vehicle)
    @vehicle = vehicle
  end

  # Returns a collection of buyers interested in the @vehicle
  # Example: BuyerFinder.new(vehicle).call
  def call
    vehicle_model = @vehicle.vehicle_model
    min_year, max_year = years_range()
    kilometers = @vehicle.kilometers
    price = get_price()

    buyers = Buyer.joins(:buyer_interests).uniq.where(
                is_hdi: @vehicle.is_hdi,
                has_automatic_transmission: @vehicle.has_automatic_transmission,
                max_price_in_cents: (price..Float::INFINITY),
                buyer_interests: {
                  vehicle_model: @vehicle.vehicle_model,
                  year: (min_year..max_year),
                  max_kilometers: (kilometers..Float::INFINITY)
                }
              )

    buyers
  end
  
  private
  
  def years_range
    min_year = @vehicle.year - Const::YEAR
    max_year = @vehicle.year + Const::YEAR
    
    return min_year, max_year
  end
  
  # Precio puede ser nil, y además para usarlo en la query tengo que
  # convertirlo a centavos ya que en la DB está guardado como price_in_cents
  def get_price
    (@vehicle.price || 0).to_i * 10_000
  end

end