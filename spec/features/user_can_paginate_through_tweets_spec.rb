require 'rails_helper'

RSpec.feature "user logs in and sees last 25 tweets" do
  scenario "user paginates through tweets" do
    VCR.use_cassette("user.paginates_tweets") do
      stub_omniauth
      visit "/"
      click_on "sign in with twitter"
      text = page.find('div#1-tweet').text
      expect(page).to have_css('div#1-tweet')
      expect(page).to have_css('div#5-tweet')
      expect(page).to have_css('div#10-tweet')
      expect(page).to have_css('div#24-tweet')

      click_on "next"

      within 'div#1-tweet' do
        expect(page).to_not have_content(text)
      end
      expect(page).to have_css('div#1-tweet')
      expect(page).to have_css('div#5-tweet')
      expect(page).to have_css('div#10-tweet')
      expect(page).to have_css('div#24-tweet')
    end
  end

  scenario "user paginates through previous tweets" do
    VCR.use_cassette("user.paginates_tweets_prev") do
      stub_omniauth
      visit "/"
      click_on "sign in with twitter"
      text = page.find('div#1-tweet').text
      expect(page).to have_css('div#1-tweet')
      expect(page).to have_css('div#5-tweet')
      expect(page).to have_css('div#10-tweet')
      expect(page).to have_css('div#24-tweet')

      click_on "next"

      within 'div#1-tweet' do
        expect(page).to_not have_content(text)
      end
      expect(page).to have_css('div#1-tweet')
      expect(page).to have_css('div#5-tweet')
      expect(page).to have_css('div#10-tweet')
      expect(page).to have_css('div#24-tweet')
    end

    click_on "prev"

    within 'div#1-tweet' do
      expect(page).to have_content(text)
    end
    expect(page).to have_css('div#1-tweet')
    expect(page).to have_css('div#5-tweet')
    expect(page).to have_css('div#10-tweet')
    expect(page).to have_css('div#24-tweet')
  end
end
