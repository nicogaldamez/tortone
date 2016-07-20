class VehicleFilter
  include ActiveModel::Model
  attr_accessor :name, :brand, :vehicle_model, :is_owner

  def call(context=false)
    vehicles = Vehicle.all

    vehicles = vehicles.joins(:customer).where(
        'customers.first_name ilike ? OR customers.last_name ilike ?',
          "%#{@name}%", "%#{@name}%"
        ) if @name.present?

    vehicles = vehicles.joins(:brand).where(
        'brands.name ilike ?', "%#{@brand}%"
        ) if @brand.present?

    vehicles = vehicles.joins(:vehicle_model).where(
        'vehicle_models.name ilike ?', "%#{@vehicle_model}%"
        ) if @vehicle_model.present?

    vehicles = vehicles.where(is_owner: true) if is_owner.present?

    vehicles.includes(:brand, :vehicle_model, :version, :customer)
  end
end
