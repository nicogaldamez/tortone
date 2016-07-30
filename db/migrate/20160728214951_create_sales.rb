class CreateSales < ActiveRecord::Migration
  def change
    create_table :sales do |t|
      t.date :sold_on
      t.belongs_to :customer, index: true, foreign_key: true
      t.belongs_to :vehicle, index: true, foreign_key: true
      t.integer :advance_in_cents, default: 0, limit: 8
      t.integer :status, default: 0 # Enumerative: 0: pending
      t.integer :price_in_cents, limit: 8
      t.text :notes

      t.timestamps null: false
    end
  end
end
