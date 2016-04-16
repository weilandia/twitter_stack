class TwitterService
  attr_reader :client

  def initialize(user)
    @_client = Twitter::REST::Client.new do |config|
      config.consumer_key    = ENV['TWITTER_TEST_KEY']
      config.consumer_secret = ENV['TWITTER_TEST_SECRET']
      config.access_token    = user.oauth_token
      config.access_token_secret = user.oauth_token_secret
    end
  end

  def user_timeline(user_screen_name)
    client.user_timeline(user_screen_name, {count: 25, include_rts: true})
  end

  private
    def client
      @_client
    end
end
