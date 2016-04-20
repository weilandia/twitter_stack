require 'rails_helper'

RSpec.feature "user logs in and views other users" do
  scenario "user visits user page that exists" do
    VCR.use_cassette("different_user_show") do
      stub_omniauth
      visit "/"
      click_on "sign in with twitter"
      fill_in "screen_name", with: "stackcommerce"
      click_on "search for users"

      expect(current_path).to eq(user_path("stackcommerce"))

      expect(page).to have_css('div#1-tweet')
      expect(page).to have_css('div#5-tweet')
      expect(page).to have_css('div#10-tweet')
      expect(page).to have_css('div#24-tweet')

      within "div.user" do
        expect(page).to have_content("StackCommerce")
        expect(page).to have_link("StackCommerce")
      end
    end
  end

 scenario "user searches for user that does not exist" do
    VCR.use_cassette("invalid_user_show") do
      stub_omniauth
      visit "/"
      click_on "sign in with twitter"
      fill_in "screen_name", with: "aaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
      click_on "search for users"

      expect(current_path).to eq(user_path(ENV['TWITTER_USER_SCREEN_NAME']))
      expect(page).to have_content("Hey, either that person doesn't exist, or they have a private account.")

      expect(page).to have_css('div#1-tweet')
      expect(page).to have_css('div#5-tweet')
      expect(page).to have_css('div#10-tweet')
      expect(page).to have_css('div#24-tweet')

      within "div.user" do
        expect(page).to have_content(ENV['TWITTER_USER_NAME'])
        expect(page).to have_link(ENV['TWITTER_USER_SCREEN_NAME'])
     end
    end
  end

  scenario "user searches for user with private account" do
     VCR.use_cassette("private_user_show") do
       stub_omniauth
       visit "/"
       click_on "sign in with twitter"
       fill_in "screen_name", with: "turing"
       click_on "search for users"

       expect(current_path).to eq(user_path(ENV['TWITTER_USER_SCREEN_NAME']))
       expect(page).to have_content("Hey, either that person doesn't exist, or they have a private account.")

       expect(page).to have_css('div#1-tweet')
       expect(page).to have_css('div#5-tweet')
       expect(page).to have_css('div#10-tweet')
       expect(page).to have_css('div#24-tweet')

       within "div.user" do
         expect(page).to have_content(ENV['TWITTER_USER_NAME'])
         expect(page).to have_link(ENV['TWITTER_USER_SCREEN_NAME'])
      end
     end
   end
end
