Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, ENV['TWITTER_TEST_KEY'], ENV['TWITTER_TEST_SECRET']
end
