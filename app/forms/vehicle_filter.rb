class VehicleFilter
  include ActiveModel::Model
  attr_accessor :name, :brand, :vehicle_model

  def call(context=false)
    vehicles = Vehicle.all

    vehicles = vehicles.joins(:customer).where(
        'customers.first_name LIKE ? OR customers.last_name LIKE ?',
          "%#{@name}%", "%#{@name}%"
        ) if @name.present?

    vehicles = vehicles.joins(:brand).where(
        'brands.name LIKE ?', "%#{@brand}%"
        ) if @brand.present?

    vehicles = vehicles.joins(:vehicle_model).where(
        'vehicle_models.name LIKE ?', "%#{@vehicle_model}%"
        ) if @vehicle_model.present?

    vehicles.includes(:brand, :vehicle_model, :version, :customer)
  end
end
