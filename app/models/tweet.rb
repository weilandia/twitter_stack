class Tweet
  attr_accessor :text, :media
  def initialize(tweet_object)
    @text = tweet_object.full_text
    @user_mentions = tweet_object.user_mentions
    @urls = tweet_object.urls
    @hashtags = tweet_object.hashtags
    @media = tweet_object.media
    add_links
  end

  def add_links
    add_links_to_user_mentions
    add_links_to_urls
    add_links_to_hash_tags
    add_media
  end

  def add_links_to_user_mentions
    @user_mentions.each do |mention|
      @text = @text.gsub("@#{mention.screen_name}", %(<a href="/users/#{mention.screen_name}" class="user-mention">@#{mention.screen_name}</a>))
    end
  end

  def add_links_to_urls
    @urls.each do |path|
      @text = @text.gsub("#{path.url}", %(<a href="#{path.url}" class="link">#{path.url}</a>))
    end
  end

  def add_links_to_hash_tags
    @hashtags.each do |hashtag|
      @text = @text.gsub("##{hashtag.text}", %(<a href="https://twitter.com/hashtag/#{hashtag.text}?src=hash" class="hashtag">##{hashtag.text}</a>))
    end
  end

  def add_media
    @media = @media.map do |object|
      @text = @text.gsub("#{object.uri.to_s}", "")
      %(<div class="tweet-image"><a href="#{object.uri.to_s}"><img src="#{object.media_url.to_s}" class="img-responsive col-xs-12"></a></div>)
    end
  end
end
