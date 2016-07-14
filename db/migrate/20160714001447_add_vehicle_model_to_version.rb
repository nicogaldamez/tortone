class AddVehicleModelToVersion < ActiveRecord::Migration
  def change
    add_reference :versions, :vehicle_model, index: true, foreign_key: true
  end
end
