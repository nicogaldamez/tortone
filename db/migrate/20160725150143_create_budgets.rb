class CreateBudgets < ActiveRecord::Migration
  def change
    create_table :budgets do |t|
      t.belongs_to :vehicle, index: true, foreign_key: true
      t.string :vehicle_description
      t.integer :year
      t.integer :price_in_cents, limit: 8
      t.integer :minimum_advance, limit: 8
      t.string :financed, default: '0'
      t.string :installments, default: '0'
      t.string :installments_cost, default: '0'
      t.string :expenses, default: '0'
      t.string :notes
      t.date :budgeted_on

      t.timestamps null: false
    end
  end
end
