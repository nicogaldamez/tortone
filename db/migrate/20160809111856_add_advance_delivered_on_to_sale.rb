class AddAdvanceDeliveredOnToSale < ActiveRecord::Migration
  def change
    add_column :sales, :advance_delivered_on, :date
  end
end
