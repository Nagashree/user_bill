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
    end
    subject {page} 
    it {should have_content(user.email)} 
    it {should have_link('Sign out')}
    it {should_not have_link('Sign up')}
    it {should_not have_link('Sign in')}
    it {should have_selector('title',:text=>"UserBill")}
    it {should have_selector('label',:text=>"Title")}
    it {should have_selector('h3',:text=>"Bills (0)")}
    describe "create a bill" do
      before do
         @bill = user.bills.build(:title=> "Lorem ipsum",:bill_date=>Time.zone.today)
         fill_in "Title", :with=> @bill.title     
      end
      it "should create a bill" do 
        expect{click_button "Add Bill"}.to change(Bill, :count).by(1)
      end
      it "correct flash message" do
        click_button "Add Bill"
        page.should have_content("Bill created")
      end
      it "should have correct bill title displayed" do
        click_button "Add Bill"
        page.should have_content(@bill.title)
        #@c_time=@bill.bill_date
        page.should have_content(@bill.bill_date)
      end
      it "should delete a bill" do
        click_button "Add Bill"
        click_link "delete"
        page.should have_content("Bill deleted")
        page.should_not have_content(@bill.title)
      end
    end
  end
  