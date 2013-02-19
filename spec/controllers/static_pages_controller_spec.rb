require 'spec_helper'

describe StaticPagesController do
	before do
		@user=FactoryGirl.create(:user)
	end
describe "GET #home" do
  it "renders the :home view" do
    get :home
    response.should render_template :home
  end
end

describe "GET #show" do

  # it "assigns the requested user to @user" do
  #  user=FactoryGirl.create(:user)
  #   get :show, :page => 1
  #   assigns(:user).should eq(user)
  # end
  it "renders the :show view" do
    sign_in @user
    get :show
    response.should render_template :show
  end
end
end
