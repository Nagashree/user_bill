require 'spec_helper'

describe Item do
	before do
   @user = User.new(:email=> "user@example.com",:password=> "password", :password_confirmation=> "password")
  @bill = Bill.new(:title=> "Lorem ipsum",:bill_date=>0.days.ago,:user_id=>@user.id)
  @item = Item.new(:item_name=> "Lorem ipsum",:amount=>50) 
end

  subject { @item }

  it { should respond_to(:item_name)}
  it { should respond_to(:amount)}
  it { should respond_to(:bill_id) }
  it { should respond_to(:bill) }

  describe "when bill_id is not present" do
    before { @item.bill_id = nil }
    it { should_not be_valid }
  end
  describe "when amount is not present" do
  	before { @item.amount = nil }
  	it { should_not be_valid}
  end
  describe "when amount is not an integer" do
  	before { @item.amount = "abdng"}
  	it {should_not be_valid}	
  end
  describe "with blank item name" do
    before { @item.item_name = " " }
    it { should_not be_valid }
  end

  describe "with item name  is too long" do
    before { @item.item_name = "a" * 120 }
    it { should_not be_valid }
  end

  end