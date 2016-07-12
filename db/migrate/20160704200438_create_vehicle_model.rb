class CreateVehicleModel < ActiveRecord::Migration
  def change
    create_table :vehicle_models do |t|
      t.references :brand, index: true, foreign_key: true
      t.string :name
      
      t.timestamps
    end
  end
end
