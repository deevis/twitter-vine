require 'spec_helper'
require 'twitter-vine'
require 'twitter-vine/client'

TwitterVine::DEBUG=true

describe TwitterVine do
  include_context "vine results"

  it "should be valid" do
    TwitterVine.should be_a(Module)
    TwitterVine::Client.should be_a(Module)
  end

  # Commented out until I set environment variables out on travis-ci
  #
  # it "should return results" do 
  #   l = TwitterVine::Client.search("Prank")
  #   puts l
  #   expect(l.size).to be > 0 
  # end

  it "should be able to scrape Vine metadata from a Twitter API result" do
    expect_results(TwitterVine::Client.send :build_vine_map, MockTweet.new)
  end

  it "should be able to scrape Vine metadata from a Twitter API result even if expanded_url is http instead of https" do
    expect_results(TwitterVine::Client.send :build_vine_map, MockTweetWithHttpVineUrl.new)
  end

  it "can parse a direct vine url" do
    expect_results(TwitterVine.parse("https://vine.co/v/b2BPEL0Orbm"))
  end

  it "can parse a direct vine url that is mistakenly http" do
    expect_results(TwitterVine.parse("http://vine.co/v/b2BPEL0Orbm"))
  end

  it "can parse an accidental embed/simple vine url" do
    expect_results(TwitterVine.parse("https://vine.co/v/b2BPEL0Orbm/embed/simple"))
  end

  it "can parse an accidental embed/simple vine url that is double mistaken with http" do
    expect_results(TwitterVine.parse("http://vine.co/v/b2BPEL0Orbm/embed/simple"))
  end


end