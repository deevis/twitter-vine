require 'spec_helper'
require 'twitter-vine'

TwitterVine::Client::DEBUG=true

describe TwitterVine do
  it "should be valid" do
    TwitterVine.should be_a(Module)
  end

  # Commented out until I set environment variables out on travis-ci
  #
  # it "should return results" do 
  #   l = TwitterVine::Client.search("Prank")
  #   puts l
  #   expect(l.size).to be > 0 
  # end

  it "should be able to scrape Vine metadata" do
    vine_map = TwitterVine.build_vine_map(MockTweet.new)
    puts vine_map
    vine_map[:vine_id].should_not be nil
    vine_map[:vine_url].should_not be nil
    vine_map[:vine_author_thumbnail].should_not be nil
    vine_map[:vine_author].should_not be nil
    vine_map[:vine_description].should_not be nil
    vine_map[:vine_src].should_not be nil
    vine_map[:vine_type].should_not be nil
  end

  it "should be able to scrape Vine metadata when expanded_url is http instead of https" do
    vine_map = TwitterVine.build_vine_map(MockTweetWithHttpVineUrl.new)
    puts vine_map
    vine_map[:vine_id].should_not be nil
    vine_map[:vine_url].should_not be nil
    vine_map[:vine_author_thumbnail].should_not be nil
    vine_map[:vine_author].should_not be nil
    vine_map[:vine_description].should_not be nil
    vine_map[:vine_src].should_not be nil
    vine_map[:vine_type].should_not be nil
  end

end