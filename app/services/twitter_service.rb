class TwitterService
  attr_reader :client

  def initialize(user, max_id=nil)
    @max_id = max_id.to_i
    @_client = Twitter::REST::Client.new do |config|
      config.consumer_key    = ENV['TWITTER_CONSUMER_KEY']
      config.consumer_secret = ENV['TWITTER_CONSUMER_SECRET']
      config.access_token    = user.oauth_token
      config.access_token_secret = user.oauth_token_secret
    end
  end

  def user_timeline(user_screen_name)
    Rails.cache.fetch("tweets/#{user_screen_name}/#{@max_id}", :expires_in => 5.minutes) do
      client.user_timeline(user_screen_name, timeline_options)
    end
  end

  def timeline_options
    options = {count: 25, include_rts: true}
    if @max_id != 0
      options[:max_id] = @max_id
    end
    options
  end

  def user(user_screen_name)
    Rails.cache.fetch("#{user_screen_name}", :expires_in => 5.minutes) do
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
