require 'spec_helper'

describe BillsController do
  before do
    @user=FactoryGirl.create(:user)
    sign_in @user
     @bill = @user.bills.create(:title=> "Lorem ipsum",:bill_date=>Time.zone.today)
   @item = @bill.items.build(:item_name=>"item-1",:amount=>"45")
    #@bill = FactoryGirl.create(:bill)
   # @bill = FactoryGirl.create(:bill)
   # @item = FactoryGirl.attributes_for(:item)
  end

 describe "POST create" do
  context "with valid attributes" do
    it "creates a new item" do
      expect{
      	#p @bill
      	#p @bill.id
        post :create, item:@item
      }.to change(Item,:count).by(1)
    end
    
    it "redirects to the show_path" do
      post :create, item: Factory.attributes_for(:item)
      response.should redirect_to show_path
    end
  end
  
  context "with invalid attributes" do
    it "does not save the new item" do
      expect{
        post :create, item: Factory.attributes_for(:invalid_item)
      }.to_not change(Item,:count)
    end
    
    it "re-renders the new method" do
      post :create, item: Factory.attributes_for(:invalid_item)
      response.should redirect_to show_path
    end
  end 
end
describe 'DELETE destroy' do
  before :each do
   @bill = @user.bills.create(:title=> "Lorem ipsum",:bill_date=>Time.zone.today)
   @item = @bill.items.create(:item_name=>"item-1",:amount=>"45")
     end
  
  it "deletes the item" do
    expect{
      delete :destroy, id: @item.to_param        
    }.to change(Item,:count).by(-1)
  end
    
  it "redirects to show page" do
    delete :destroy, id: @item.to_param
    response.should redirect_to show_path
  end
end

end