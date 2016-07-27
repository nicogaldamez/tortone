class AddAutomaticTransmissionToVehicle < ActiveRecord::Migration
  def change
    add_column :vehicles, :has_automatic_transmission, :boolean, default: false
  end
end
