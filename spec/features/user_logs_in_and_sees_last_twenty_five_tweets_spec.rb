require 'rails_helper'

RSpec.feature "user logs in and sees last 25 tweets" do
  scenario "user logs in successfully" do
    VCR.use_cassette("user.tweets") do
      stub_omniauth
      visit "/"
      click_on "signin with twitter"
      expect(page).to have_css('div#1-tweet')
      expect(page).to have_css('div#5-tweet')
      expect(page).to have_css('div#10-tweet')
      expect(page).to have_css('div#24-tweet')
    end
 end
end
