require 'rails_helper'

RSpec.feature "user logs in and sees profile info" do
  scenario "user logs in successfully" do
    VCR.use_cassette("user.info") do
      stub_omniauth
      visit "/"
      click_on "signin with twitter"
      within "div.user" do
        expect(page).to have_content(ENV['TWITTER_USER_NAME'])
        expect(page).to have_link(ENV['TWITTER_USER_SCREEN_NAME'])
      end
    end
 end
end
