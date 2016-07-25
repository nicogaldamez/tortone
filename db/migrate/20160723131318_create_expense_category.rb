class CreateExpenseCategory < ActiveRecord::Migration
  def change
    create_table :expense_categories do |t|
      t.string :name
      t.text :description
    end
  end
end
