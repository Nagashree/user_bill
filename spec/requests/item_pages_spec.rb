require 'spec_helper'
  describe "show bills in bill page" do
    let(:user) { FactoryGirl.create(:user) }
   # let(:bill) {user.FactoryGirl.create(:bill)}
    before do
     visit new_user_session_path
     fill_in "Email",        :with=> user.email
     fill_in "Password",     :with=> user.password
     click_button "Sign in"
     click_link "Profile"
     @bill = user.bills.build(:title=> "Lorem ipsum",:bill_date=>Time.zone.today)
     fill_in "Title", :with=> @bill.title 
     click_button "Add Bill"  
     @item = Item.new(:item_name=> "item-1",:amount=>50)   
    end
    subject {page} 
    it {should have_selector('label',:text=>"Item name")}
    it {should have_selector('label',:text=>"Amount")}
    describe "create a item" do
      before do
         fill_in "Item name", :with=> @item.item_name
         fill_in "Amount", :with=> @item.amount 
      end
      it "should create a item" do 
        expect{click_button "add item"}.to change(Item, :count).by(1)
      end
      it "correct flash message" do
        click_button "add item"
        page.should have_content("Item added!")
      end
      it "should have correct item name && amount displayed" do
        click_button "add item"
        page.should have_content(@item.item_name)
        page.should have_content(@item.amount)
      end
      it "should delete a item" do
        click_button "add item"
        click_link "remove"
        page.should have_content("Item removed")
        page.should_not have_content(@item.item_name)
      end
    end
  end
  