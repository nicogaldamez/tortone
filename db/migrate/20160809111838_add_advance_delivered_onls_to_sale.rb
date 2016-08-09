class AddAdvanceDeliveredOnlsToSale < ActiveRecord::Migration
  def change
    add_column :sales, :advance_date, :date
  end
end
