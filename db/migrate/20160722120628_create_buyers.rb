class CreateBuyers < ActiveRecord::Migration
  def change
    create_table :buyers do |t|
      t.string :first_name, null: false
      t.string :last_name
      t.string :phones, null: false
      t.string :email
      t.boolean :is_hdi, default: false
      t.boolean :has_automatic_transmission, default: false
      t.integer :min_price_in_cents, limit: 8, default: 0
      t.integer :max_price_in_cents, limit: 8
      t.text :notes

      t.timestamps null: false
    end
  end
end
