require 'spec_helper'

describe BillsController do
  before do
    @user=FactoryGirl.create(:user)
    sign_in @user
  end

  describe "GET 'create'" do
    it "returns http success" do
      get 'create', bill: Factory.attributes_for(:bill)
      response.should be_success
    end
  end

  describe "GET 'destroy'" do
    it "returns http success" do
      @bill=Bill.find(params[:id])
      get 'destroy'
      response.should be_success
    end
  end

end
#describe ClusterController do
 # describe "POST create" do
  #  it "creates a new cluster" do
   #   lamda do 
    #    post :create
     # end.should change(Cluster, :count).by(1)
    #end