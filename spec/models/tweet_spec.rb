require 'rails_helper'

RSpec.describe Tweet, :type => :model do
  include MockTweetObject
  it "parses user mentions in tweet" do
    twitter_tweet_object = mock_twitter_tweet
    tweet_poro = Tweet.new(twitter_tweet_object)

    expect(twitter_tweet_object.full_text).to_not eq(tweet_poro.text)

    expect(tweet_poro.text.include?("<a href=\"/users/howardmarks\" class=\"user-mention\">@howardmarks</a>")).to be true
  end

  it "parses urls in tweet" do
    twitter_tweet_object = mock_twitter_tweet
    tweet_poro = Tweet.new(twitter_tweet_object)

    expect(twitter_tweet_object.full_text).to_not eq(tweet_poro.text)

    expect(tweet_poro.text.include?("<a href=\"https://t.co/B9AhWAhnVS\" class=\"link\">https://t.co/B9AhWAhnVS</a>")).to be true
  end

  it "parses media in tweet" do
    twitter_tweet_object = mock_twitter_tweet
    tweet_poro = Tweet.new(twitter_tweet_object)

    expect(twitter_tweet_object.full_text).to_not eq(tweet_poro.text)

    expect(tweet_poro.text.include?("<a href=\"https://twitter.com/hashtag/startups?src=hash\" class=\"hashtag\">#startups</a>")).to be true
  end

  it "parses full tweet" do
    twitter_tweet_object = mock_twitter_tweet
    tweet_poro = Tweet.new(twitter_tweet_object)

    expect(twitter_tweet_object.full_text).to_not eq(tweet_poro.text)

    expect(tweet_poro.text).to eq("RT <a href=\"/users/howardmarks\" class=\"user-mention\">@howardmarks</a>: Slack raises $200m at $3.8b valuation for business messaging <a href=\"https://t.co/B9AhWAhnVS\" class=\"link\">https://t.co/B9AhWAhnVS</a> <a href=\"https://twitter.com/hashtag/startups?src=hash\" class=\"hashtag\">#startups</a> ")
  end
end
