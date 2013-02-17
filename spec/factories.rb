FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "person_#{n}@example.com"}   
    password "foobar12"
    password_confirmation "foobar12"
  end

  factory :bills do
    sequence(:title) { |n| "bill_#{n}"}
    bill_date = Date
    user
  end

  factory :items do
    sequence(:item_name) { |n| "Item_#{n}"}
    amount =Random.rand(100)
    bill
  end
end