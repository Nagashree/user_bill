require 'spec_helper'

describe StaticPagesController do
	before do
		@user=FactoryGirl.create(:user)
		sign_in @user
	end
describe "GET #home" do
  it "renders the :home view" do
    get :home
    response.should render_template :home
  end
end

describe "GET #show" do
  it "renders the :show view" do
    get :show
    response.should render_template :show
  end
end
end
