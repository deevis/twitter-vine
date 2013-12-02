# Load support files
require 'twitter-vine'
require 'twitter-vine/client'

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  # Remove this line if you don't want RSpec's should and should_not
  # methods or matchers
  require 'rspec/expectations'
  config.include RSpec::Matchers

  # == Mock Framework
  config.mock_with :rspec
end

TwitterVine::Client.setup do |c|
  c.api_key = ENV["BT_TWITTER_API_KEY"]
  c.api_secret = ENV["BT_TWITTER_API_SECRET"]
  c.oauth_token = ENV["BT_TWITTER_OAUTH_TOKEN"]
  c.oauth_secret = ENV["BT_TWITTER_OAUTH_TOKEN_SECRET"]
end

class MockTweet
  def url;"https://twitter.com/DesliParra/status/407413145792413696";end
  def urls;[{display_url:"vine.co/v/hF7WOEl76T1", expanded_url:"https://vine.co/v/hF7WOEl76T1"}];end  
end


class MockTweetWithHttpVineUrl
  def url;"https://twitter.com/DesliParra/status/407413145792413696";end
  def urls;[{display_url:"vine.co/v/hF7WOEl76T1", expanded_url:"http://vine.co/v/hF7WOEl76T1"}];end  
end

shared_context "vine results" do

  def expect_results(vine_map)
    puts vine_map
    vine_map[:vine_id].should_not be nil
    vine_map[:vine_url].should_not be nil
    vine_map[:vine_thumbnail].should_not be nil
    vine_map[:vine_author_thumbnail].should_not be nil
    vine_map[:vine_author].should_not be nil
    vine_map[:vine_description].should_not be nil
    vine_map[:vine_src].should_not be nil
    vine_map[:vine_type].should_not be nil
  end
end