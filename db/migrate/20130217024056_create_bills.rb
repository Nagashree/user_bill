class CreateBills < ActiveRecord::Migration
  def change
    create_table :bills do |t|
      t.string :title
      t.date :bill_date
      t.integer :user_id

      t.timestamps
    end
    add_index :bills, [:user_id, :created_at]
  end
end
