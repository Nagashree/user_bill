require 'spec_helper'

describe User do
  	before do
    @user = User.new(:email=> "user@example.com",:password=> "password", :password_confirmation=> "password")
  	end
  	it "has a valid factory" do
    	FactoryGirl.create(:user).should be_valid
  	end
	subject{ @user }
   		it { should respond_to(:email) }
  		it { should respond_to(:password_digest) }
  		it { should respond_to(:password) }
  		it { should respond_to(:password_confirmation) }
      it { should respond_to(:bills)}
   		it {should be_valid}
    describe "when email is not present" do
    		before { @user.email = " " }
    		it { should_not be_valid }
    end
  	describe "when password is not present" do
  			before { @user.password = @user.password_confirmation = " " }
  			it { should_not be_valid }
	end
	describe "when password doesn't match confirmation" do
    		before { @user.password_confirmation = "mismatch" }
    		it { should_not be_valid }
  	end
	describe "when password confirmation is nil" do
    		before { @user.password_confirmation = nil }
    		it { should_not be_valid }
  	end
  	describe "with a password that's too short" do
  			before { @user.password = @user.password_confirmation = "a" * 5 }
  			it { should be_invalid }
	end
 	describe "when email format is invalid" do
    	it "should be invalid" do
      		addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com]
      		addresses.each do |invalid_address|
        		@user.email = invalid_address
        		@user.should_not be_valid
      		end      
    	end
  	end
	describe "when email format is valid" do
    	it "should be valid" do
      		addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      		addresses.each do |valid_address|
        		@user.email = valid_address
        		@user.should be_valid
      		end      
    	end
  	end
  	describe "when email address is already taken" do
    	before do
     		user_with_same_email = @user.dup
      		user_with_same_email.email = @user.email.upcase
      		user_with_same_email.save
    	end
  		it { should_not be_valid }
	  end
  describe "bills associations" do

    before { @user.save }
    let!(:older_bill) do 
      FactoryGirl.create(:bill, :user=> @user,:title=>"bill 1", :bill_date=> 1.day.ago)
    end
    let!(:newer_bill) do
      FactoryGirl.create(:bill, :user=> @user,:title=>"bill 2", :bill_date=> 1.hour.ago)
    end

    it "should have the right bills in the right order" do
      @user.bills.should == [newer_bill, older_bill]
    end
  end
end
