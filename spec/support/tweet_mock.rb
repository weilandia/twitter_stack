module MockTweetObject
  def mock_twitter_tweet
    OpenStruct.new({
      full_text: "RT @howardmarks: Slack raises $200m at $3.8b valuation for business messaging https://t.co/B9AhWAhnVS #startups https://t.co/m1AhVp4Fgs",
      user_mentions: build_user_mentions,
      urls: build_urls,
      hashtags: build_hashtags,
      media: build_media
      })
  end

  def build_user_mentions
    [OpenStruct.new({
      screen_name: "howardmarks"
      })]
  end

  def build_urls
    [OpenStruct.new({
      url: "https://t.co/B9AhWAhnVS"
      })]
  end

  def build_hashtags
    [OpenStruct.new({
      text: "startups"
      })]
  end

  def build_media
    [OpenStruct.new({
      uri: "https://t.co/m1AhVp4Fgs",
      media_url: "https://twitter.com/howardmarks/status/715954664060137474/photo/1"
      })]
  end
end
