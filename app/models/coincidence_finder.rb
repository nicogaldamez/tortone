class CoincidenceFinder
  
  def initialize(vehicle:, interest:)
    @vehicle  = vehicle
    @interest = interest
  end
  
  def call
    buyer = @interest.buyer
    conditions = []

    conditions << is_between_years?
    conditions << @vehicle.is_hdi? if buyer.is_hdi?
    conditions << @vehicle.has_automatic_transmission? if buyer.has_automatic_transmission?
    conditions << is_between_prices?(buyer.min_price, buyer.max_price) if buyer.max_price.present? || buyer.min_price != 0
    conditions << is_between_kilometers? if @interest.max_kilometers.present?

    conditions.all?
  end
  
  
  private
  
    def is_between_years?
      @vehicle.year >= (@interest.year - Const::YEAR) && 
                @vehicle.year <= (@interest.year + Const::YEAR)
    end

    def is_between_prices?(min, max)
      return true if !@vehicle.price
  
      max ||= Float::INFINITY    
      (@vehicle.price >= min && @vehicle.price <= max)
    end

    def is_between_kilometers?
      @vehicle.kilometers <= @interest.max_kilometers
    end
  
end