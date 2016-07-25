class CreateBuyerInterests < ActiveRecord::Migration
  def change
    create_table :buyer_interests do |t|
      t.belongs_to :buyer, index: true, foreign_key: true
      t.belongs_to :brand, index: true, foreign_key: true
      t.belongs_to :vehicle_model, index: true, foreign_key: true
      t.integer :year, null: false
      t.integer :max_kilometers

      t.timestamps null: false
    end
  end
end
