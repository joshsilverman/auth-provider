require 'spec_helper'

describe "users" do
	before(:each) do
    if example.metadata[:js]
      Capybara.current_driver = :selenium
      Capybara.default_wait_time = 3
    else
      Capybara.current_driver = :rack_test
    end
  end

  describe "sign up" do
    it "with correct info" do
    end

    it "with incorrect info" do
    end
  end

  describe "sign in" do
    it "signs in with correct info" do
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
