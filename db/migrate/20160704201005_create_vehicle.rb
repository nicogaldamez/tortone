class CreateVehicle < ActiveRecord::Migration
  def change
    create_table :vehicles do |t|
      t.references :brand, index: true, foreign_key: true
      t.references :vehicle_model, index: true, foreign_key: true
      t.references :version, index: true, foreign_key: true
      t.references :customer, index: true, foreign_key: true
      t.integer :kilometers
      t.string :color
      t.text :details
      t.integer :cost_in_cents, limit: 8
      t.integer :price_in_cents, limit: 8
      t.date :entered_on
      t.date :sold_on
      t.boolean :is_exchange, default: false
      t.boolean :is_consignment, default: false
      t.boolean :is_financed, default: false
      t.integer :minimum_advance_in_cents, limit: 8
      t.integer :transfer_amount_in_cents, limit: 8
      t.string :plate
      t.integer :year
      t.string :motor_number
      t.string :chassis_number

      t.timestamps
    end
  end
end
