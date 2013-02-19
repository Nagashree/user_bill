 require 'spec_helper'
  describe "signup page" do
    before { visit new_user_registration_path }
    subject {page} 
    it {should have_content("Sign up")} 
    it {should have_link('Sign in')}
    it {should have_selector('title',:text=>"UserBill")}
  end
  describe "signup" do

    before { visit new_user_registration_path }

    let(:submit) { "Sign up" }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "Email",        :with=> "user@example.com"
        fill_in "Password",     :with=> "password"
        fill_in "Password confirmation", :with=> "password"
        end
      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end
      it "correct flash message" do
        click_button submit
        page.should have_content("Welcome! You have signed up successfully.")
      end
    end
  end
  describe "signin page" do
    before { visit new_user_session_path }
    subject {page} 
    it {should have_content("Sign in")} 
    it {should have_link('Sign up')}
    it {should have_selector('title',:text=>"UserBill")}
  end
  describe "signin" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit new_user_session_path }

    let(:submit) { "Sign in" }

    describe "with invalid information" do
      it "should not login" do
        click_button "Sign in"
        page.should have_content("Invalid email or password.")
      end
    end

    describe "with valid information" do
      before do
        fill_in "Email",        :with=> user.email
        fill_in "Password",     :with=> user.password
        click_button "Sign in"
        end

      it "should sign in a user" do
        page.should have_content("Signed in successfully.")
        page.should have_link("Profile")
        page.should have_content(user.email)
      end
    end
  end
  describe "forgot password page" do
     before do
      visit new_user_session_path
      click_link "Forgot your password?" 
    end
    subject {page}
    it {should have_content("Forgot your password?")} 
    it {should have_link('Sign up')}
    it {should have_link('Sign in')}
    it {should have_selector('title',:text=>"UserBill")}
  end
  describe "forgot password" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      visit new_user_session_path
      click_link "Forgot your password?" 
    end
    let(:submit) { "Send me reset password instructions" }

    describe "with email blank information" do
      it "should not send instructions" do
        click_button "Send me reset password instructions"
        page.should have_content("Email can't be blank")
      end
    end

    describe "with invalid email information" do
      it "should not send instructions" do
        fill_in "Email",        :with=> "nagashree.aswath@gmail.com"
        click_button "Send me reset password instructions"
        page.should have_content("Email not found")
      end
    end

    describe "with valid information" do
      before do
        fill_in "Email",        :with=> user.email
        click_button "Send me reset password instructions"
        end

      it "should send the instructions" do
        page.should have_content("You will receive an email with instructions about how to reset your password in a few minutes.")
        page.should have_content("Sign in")
      end
    end
  end
  describe "sign out" do
    let(:user) { FactoryGirl.create(:user) }
    before do
     visit new_user_session_path
     fill_in "Email",        :with=> user.email
     fill_in "Password",     :with=> user.password
     click_button "Sign in"
    end
    describe "in home page" do
      it "should log out" do
        click_link "Sign out"
        page.should have_content("Sign in")
        page.should have_content("Signed out successfully.")
      end
    end

    describe "in show page" do
      it "should log out" do
        click_link "Profile"
        click_link "Sign out"
        page.should have_content("Sign in")
        page.should have_content("Signed out successfully.")
      end
    end
  end