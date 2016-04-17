require 'rails_helper'

RSpec.feature "user logs in" do
  scenario "user logs in successfully" do
    VCR.use_cassette("sessions.login") do
      stub_omniauth
      visit "/"
      click_on "sign in with twitter"
      expect(page).to have_content("logout")
      expect(page).to_not have_content("sign in with twitter")
    end
 end
end
