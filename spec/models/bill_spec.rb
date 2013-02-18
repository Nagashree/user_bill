require 'spec_helper'

describe Bill do

  let(:user) { FactoryGirl.create(:user) }

  before { @bill = user.bills.build(:title=> "Lorem ipsum",:bill_date=>0.days.ago) }

  subject { @bill }

  it { should respond_to(:title) }
  it { should respond_to(:bill_date)}
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  it { should respond_to(:items)}
  its(:user) { should == user }

  it { should be_valid }

  describe "when user_id is not present" do
    before { @bill.user_id = nil }
    it { should_not be_valid }
  end
  describe "with blank title" do
    before { @bill.title = " " }
    it { should_not be_valid }
  end

  describe "with title is too long" do
    before { @bill.title = "a" * 120 }
    it { should_not be_valid }
  end

  describe "when title is already taken" do
    	before do
     		bill_with_same_title = @bill.dup
      		bill_with_same_title.title = @bill.title.upcase
      		bill_with_same_title.save
    	end
  		it { should_not be_valid }
   end
    describe "items associations" do

    before { @bill.save }
    let!(:older_item) do 
      FactoryGirl.create(:item,:bill=>@bill,:item_name=>"bill 1",:amount=>50, :created_at=> 1.day.ago)
    end
    let!(:newer_item) do
      FactoryGirl.create(:item,:bill=>@bill,:item_name=>"bill 2",:amount=>50, :created_at=> 1.hour.ago)
    end

    it "should have the right items in the right order" do
      @bill.items.should == [newer_item, older_item]
    end
  end
end