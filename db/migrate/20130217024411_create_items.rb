class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :item_name
      t.integer :amount
      t.integer :bill_id

      t.timestamps
    end
    add_index :items, [:bill_id, :created_at]
  end
end
