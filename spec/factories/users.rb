FactoryGirl.define do
  factory :user do
    name "User Test"
    screen_name ENV['TWITTER_USER_SCREEN_NAME']
    uid "12345"
    oauth_token ENV['TWITTER_USER_OAUTH_TOKEN']
    oauth_token_secret ENV['TWITTER_USER_SECRET_TOKEN']
  end
end
