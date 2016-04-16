require "rails_helper"

RSpec.describe "GET /api.twitter.com/1.1/users/:screen_name/show" do

  describe "#user(user.screen_name)" do
    it "given a username, it returns the that user's profile info" do
      stub_omniauth
      user = create(:user)
      client = TwitterService.new(user)
      VCR.use_cassette('user_show') do
        user_info = client.user(user.screen_name)
        expect(user_info.class).to eq(Twitter::User)
        expect(user_info.name).to eq(ENV['TWITTER_USER_NAME'])
      end
    end
  end
end
