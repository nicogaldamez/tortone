class AddCashInCentsToSale < ActiveRecord::Migration
  def change
    add_column :sales, :cash_in_cents, :integer, limit: 8, default: 0
  end
end
