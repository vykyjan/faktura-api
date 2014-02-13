require 'spec_helper'

describe User do

  describe "user registration" do
    it "allows new users to register with an email address and password" do
      visit new_user_registration_path


      fill_in "user[email]",                 :with => "abc@example.com"
      fill_in "user[password]",              :with => "abcdef123"
      fill_in "user[password_confirmation]", :with => "abcdef123"
      click_button "Sign up"

      expect { click_button submit }.to change(User, :count).by(1)
      response.should be_redirect
      response.should have_content("Welcome! You have signed up successfully.")
    end
  end
end