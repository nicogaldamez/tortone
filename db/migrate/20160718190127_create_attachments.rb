class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.string :file_uid
      t.string :file_name
      t.belongs_to :vehicle, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
