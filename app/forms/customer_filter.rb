class CustomerFilter
  include ActiveModel::Model
  attr_accessor :name, :vehicle

  def call(context=false)
    customers = Customer.all
    customers = customers.where('first_name like ? OR last_name like ?', "%#{@name}%", "%#{@name}%") if @name.present?
    customers = customers.joins(:vehicles)
                .where('vehicles.brand_id IN
                        (SELECT brands.id
                         FROM brands INNER JOIN vehicles
                         WHERE brands.name LIKE ?)
                         OR
                         vehicles.vehicle_model_id IN
                         (SELECT vehicle_models.id
                         FROM vehicle_models INNER JOIN vehicles
                         WHERE vehicle_models.name LIKE ?)', "%#{@vehicle}%", "%#{@vehicle}%").uniq if @vehicle.present?
    
    customers
  end
end
