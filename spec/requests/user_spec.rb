require 'spec_helper'

describe "users" do
	before(:each) do
    if example.metadata[:js]
      Capybara.current_driver = :selenium
      Capybara.default_wait_time = 10
    else
      Capybara.current_driver = :rack_test
    end
  end

  describe "sign up" do
    it "with correct info" do
      visit "/users/sign_up"
      fill_in "Email", :with => "test@example.com"
      fill_in "Password", :with => "password"
      fill_in "Password confirmation", :with => "password"
      click_button "Sign up"
      puts current_path
    end

    it "with incorrect info" do
      visit "/users/sign_up"
      fill_in "Email", :with => "test"
      fill_in "Password", :with => "password"
      fill_in "Password confirmation", :with => "password"
      click_button "Sign up"
      puts current_path
    end
  end

  describe "sign in" do
    before :each do
      @user = Factory.create(:user)
      @user.save!
    end

    it "signs in with correct info" do
      visit "/users/sign_in"
      fill_in "Email", :with => @user.email
      fill_in "Password", :with => @user.password
      click_button "Sign in"
      wait_until{ page.has_content?('My Eggs')}
    end

    it "signs in with incorrect info" do
    end

    it "signs in with school specific account" do
    end
  end

  describe "edit account" do 
    it "accesses edit without being logged in" do
    end

    it "edits info with password" do
    end

    it "edits info with no password" do
    end

    it "edits info with bad password" do
    end
  end

  describe "sign out" do
    it "signs out from www" do
    end

    it "signs out from school subdomain" do
    end
  end
end
