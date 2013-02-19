FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "person_#{n}@example.com"}   
    password "foobar12"
    password_confirmation "foobar12"
  end

  factory :bill do
    sequence(:title) { |n| "bill_#{n}"}
    bill_date  Time.zone.today
    user
  end

  factory :item do
    sequence(:item_name) { |n| "Item_#{n}"}
    amount =Random.rand(100)
    bill
  end
  factory :invalid_bill, parent: :bill do |f|
      f.title nil
  end
  factory :invalid_item, parent: :item do |f|
      f.item_name nil
      f.amount nil
end
end