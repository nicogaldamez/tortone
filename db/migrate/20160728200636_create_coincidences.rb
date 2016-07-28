class CreateCoincidences < ActiveRecord::Migration
  def change
    create_table :coincidences do |t|
      t.references :buyer, index: true, foreign_key: true
      t.references :vehicle_model, index: true, foreign_key: true
      t.references :brand, index: true, foreign_key: true
      t.boolean :is_ignored, default: false

      t.timestamps null: false
    end
  end
end
