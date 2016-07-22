class AddHdiToVehicle < ActiveRecord::Migration
  def change
    add_column :vehicles, :is_hdi, :boolean, default: false
  end
end
