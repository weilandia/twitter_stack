require 'rails_helper'

RSpec.feature "user logs in then visits root" do
  scenario "user gets redirected to user_path(user)" do
    VCR.use_cassette("sessions.login") do
      stub_omniauth
      visit "/"
      click_on "sign in with twitter"

      expect(current_path).to eq(user_path(ENV['TWITTER_USER_SCREEN_NAME']))

      visit "/"

      expect(current_path).to eq(user_path(ENV['TWITTER_USER_SCREEN_NAME']))
    end
 end
end
