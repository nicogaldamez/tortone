class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :dni
      t.string :phones
      t.string :address
      t.string :email
      t.text :description

      t.timestamps null: false
    end
    add_index :customers, :first_name
    add_index :customers, :last_name
    add_index :customers, :email
  end
end
