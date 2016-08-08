class RemoveDescriptionFromExpenseCategory < ActiveRecord::Migration
  def up
    remove_column :expense_categories, :description
  end
  
  def down
    add_column :expense_categories, :description, :text
  end
end
