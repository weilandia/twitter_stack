require 'coveralls'
Coveralls.wear!

module OmniauthMock
  def stub_omniauth
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new({
      provider: 'twitter',
      uid: "12345",
      extra: {
        raw_info: {
          screen_name: "weilandia",
        }
      },
      info:
        { name: "Nick Weiland",
          email: nil,
          location: "",
          image: "http://pbs.twimg.com/profile_images/666098907974270976/xbPFH5qZ_normal.jpg",
          description:
          "Really just trying to do some good in this place.",
          urls: {"Website"=>nil, Twitter: "https://twitter.com/weilandia"}},
      credentials: {
        token: ENV['TWITTER_TEST_KEY'],
        secret:ENV['TWITTER_TEST_SECRET']
      }
    })
  end
end

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
  config.include OmniauthMock
end
