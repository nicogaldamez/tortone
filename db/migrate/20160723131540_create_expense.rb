class CreateExpense < ActiveRecord::Migration
  def change
    create_table :expenses do |t|
      t.date :incurred_on
      t.references :expense_category, index: true, foreign_key: true
      t.integer :amount_in_cents, limit: 8
      t.text :description
    end
  end
end
