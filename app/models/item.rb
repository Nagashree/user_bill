class Item < ActiveRecord::Base
  attr_accessible :amount, :item_name,:bill_id,:created_at
  belongs_to :bill
  validates :bill_id, :presence=> true 
  validates :amount,:presence=>true, :numericality => {:only_integer => true}
  validates :item_name,:presence=>true,:length=> { :maximum=> 50 }
  default_scope :order=> 'items.created_at DESC' 
end
