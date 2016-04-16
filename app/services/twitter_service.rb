class TwitterService
  attr_reader :client

  def initialize(user)
    @_client = Twitter::REST::Client.new do |config|
      config.consumer_key    = ENV['TWITTER_CONSUMER_KEY']
      config.consumer_secret = ENV['TWITTER_CONSUMER_KEY_SECRET']
      config.access_token    = user.oauth_token
      config.access_token_secret = user.oauth_token_secret
    end
  end

  def user_timeline(user_screen_name)
    Rails.cache.fetch("tweets/#{user_screen_name}", :expires_in => 10.hours) do
      client.user_timeline(user_screen_name, {count: 25, include_rts: true})
    end
  end

  def user(user_screen_name)
    Rails.cache.fetch("#{user_screen_name}", :expires_in => 10.hours) do
      if client.user?(user_screen_name)
        client.user(user_screen_name)
      end
    end
  end

  private
    def client
      @_client
    end
end
