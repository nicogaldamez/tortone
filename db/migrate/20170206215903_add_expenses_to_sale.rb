class AddExpensesToSale < ActiveRecord::Migration
  def change
    add_column :sales, :expenses_in_cents, :integer, limit: 8, default: 0
  end
end
