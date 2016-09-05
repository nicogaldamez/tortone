class SaleFilter
  include ActiveModel::Model
  attr_accessor :from, :to, :vehicle_model_id, :brand_and_model_name

  def call
    sales = Sale.all
    sales = sales.where('sold_on >= ?', @from.to_date) if @from.present?
    sales = sales.where('sold_on <= ?', @to.to_date) if @to.present?
    if @vehicle_model_id.present?
      vehicle_model = VehicleModel.find(@vehicle_model_id)
      @brand_and_model_name = "#{vehicle_model.brand.name} #{vehicle_model.name}"
      sales = sales.joins(:vehicle).where('vehicles.vehicle_model_id = ?', @vehicle_model_id)
    end
    sales
  end
end
