class Bill < ActiveRecord::Base
  attr_accessible :bill_date, :title,:user_id
  has_many :items, dependent: :destroy
  belongs_to :user
  before_save { |bill| bill.title = title.downcase }
  validates :user_id, presence: true 
  validates :title, :presence=> true, :length=> { :maximum=> 50 },:uniqueness=> { :case_sensitive=> false }
  validates :bill_date, :presence=>true
  default_scope :order=> 'bills.created_at DESC' 
end
