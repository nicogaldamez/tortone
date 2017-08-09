class AddTransferAmountInCentsToSale < ActiveRecord::Migration
  def change
    add_column :sales, :transfer_amount_in_cents, :integer, limit: 8
  end
end
