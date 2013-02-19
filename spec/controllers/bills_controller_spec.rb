require 'spec_helper'

describe BillsController do
  before do
    @user=FactoryGirl.create(:user)
    sign_in @user
    @bill = FactoryGirl.attributes_for(:bill)
  end

 describe "POST create" do
  context "with valid attributes" do
    it "creates a new bill" do
      expect{
        post :create, bill: Factory.attributes_for(:bill)
      }.to change(Bill,:count).by(1)
    end
    
    it "redirects to the new contact" do
      post :create, bill: Factory.attributes_for(:bill)
      response.should redirect_to show_path
    end
  end
  
  context "with invalid attributes" do
    it "does not save the new contact" do
      expect{
        post :create, bill: Factory.attributes_for(:invalid_bill)
      }.to_not change(Bill,:count)
    end
    
    it "re-renders the new method" do
      post :create, bill: Factory.attributes_for(:invalid_bill)
      response.should redirect_to show_path
    end
  end 
end
describe 'DELETE destroy' do
  before :each do
   @bill = @user.bills.create(:title=> "Lorem ipsum",:bill_date=>Time.zone.today)
  end
  
  it "deletes the bill" do
    expect{
      delete :destroy, id: @bill.to_param        
    }.to change(Bill,:count).by(-1)
  end
    
  it "redirects to show page" do
    delete :destroy, id: @bill.to_param
    response.should redirect_to show_path
  end
end

end