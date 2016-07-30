class RemoveMinPriceInCentsFromBuyer < ActiveRecord::Migration
  def up
    remove_column :buyers, :min_price_in_cents
  end
  
  def down
    add_column :buyers, :min_price_in_cents, :integer, limit: 8, default: 0
  end
end
