class CustomerFilter
  include ActiveModel::Model
  attr_accessor :name, :vehicle

  def call(context=false)
    customers = Customer.active
    customers = customers.where('first_name ilike ? OR last_name ilike ?', "%#{@name}%", "%#{@name}%") if @name.present?
    customers = customers.joins(:vehicles)
                .where('vehicles.brand_id IN
                        (SELECT brands.id
                         FROM brands, vehicles
                         WHERE brands.name ILIKE ?)
                         OR
                         vehicles.vehicle_model_id IN
                         (SELECT vehicle_models.id
                         FROM vehicle_models, vehicles
                         WHERE vehicle_models.name ILIKE ?)', "%#{@vehicle}%", "%#{@vehicle}%").uniq if @vehicle.present?


    customers
  end
end
