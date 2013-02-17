class Bill < ActiveRecord::Base
  attr_accessible :bill_date, :title,:user_id
  has_many :items, dependent: :destroy
  belongs_to :user
  validates :user_id, presence: true 
end
