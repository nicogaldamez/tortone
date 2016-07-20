class AddIsOwnerToVehicle < ActiveRecord::Migration
  def change
    add_column :vehicles, :is_owner, :boolean, default: false
  end
end
