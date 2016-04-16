require "rails_helper"

RSpec.describe "GET /api.twitter.com/1.1/statuses/user_timeline" do

  describe "#user_timeline(user.screen_name)" do
    it "given a username, it returns the that user's last 25 tweets" do
      stub_omniauth
      user = create(:user)
      client = TwitterService.new(user)
      VCR.use_cassette('twitter/user_timeline') do
        tweets = client.user_timeline(user.screen_name)
        expect(tweets.class).to eq(Array)
        expect(tweets.first.class).to eq(Twitter::Tweet)
        expect(tweets.length).to eq(25)
      end
    end
  end
end
