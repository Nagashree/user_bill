namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    10.times do |n|
    email = "example-#{n+1}@railstutorial.org"
    password  = "password"
    user=User.create!( :email=>    email,
                 :password=> password,
                 :password_confirmation=> password)
     5.times do |m|
        title = "bill-#{m+1}"
        bill_date=rand_time(2.days.ago)
        bill=Bill.create!(:title=> title,:bill_date=>bill_date,:user_id=>user.id)
      #users.each { |user| user.bills.create!(:content=> content,:bill_date=>bill_date)}
        3.times do |k|
          item_name = "item-#{k+1}"
          amount=Integer(rand_price(10,100))
          item=Item.create!(:item_name=>item_name,:amount=>amount,:bill_id=>bill.id)
       #   bills.each { |bills|  bills.items.create(:item_name=>item_name,:amount=>amount)}
        end
    end
  end
 end
end
def rand_time(from, to=Time.now)
  Time.at(rand_in_range(from.to_f, to.to_f))
end
def rand_price(from, to)
  rand_in_range(from, to).round(2)
end
def rand_in_range(from, to)
  rand * (to - from) + from
end