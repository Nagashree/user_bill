class Item < ActiveRecord::Base
  attr_accessible :amount, :item_name,:bill_id
  belongs_to :bill
  validates :bill_id, presence: true 
end
