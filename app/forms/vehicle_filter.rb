class VehicleFilter
  include ActiveModel::Model
  attr_accessor :name, :brand_id, :vehicle_model_id

  def call(context=false)
    vehicles = Vehicle.all
    vehicles = vehicles.includes(:customers).where('customer.first_name like ? OR customer.last_name like ?', "%#{@name}%", "%#{@name}%") if @name.present?
    vehicles = vehicles.where(brand_id: @brand_id ) if @brand_id.present?
    vehicles = vehicles.where(vehicle_model_id: @vehicle_model_id) if @vehicle_model_id.present?

    vehicles
  end
end
