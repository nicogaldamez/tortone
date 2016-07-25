class RemoveIsExchangeFromVehicle < ActiveRecord::Migration
  def change
    remove_column :vehicles, :is_exchange
  end
end
