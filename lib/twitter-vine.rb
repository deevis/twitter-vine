require 'twitter-vine/version'
require 'twitter'
require 'nokogiri'

module TwitterVine

    def self.api_key; @@api_key; end
    def self.api_key=(val); @@api_key=val; end

    def self.api_secret; @@api_secret; end
    def self.api_secret=(val); @@api_secret=val; end

    def self.oauth_token; @@oauth_token; end
    def self.oauth_token=(val); @@oauth_token=val; end

    def self.oauth_secret; @@oauth_secret; end
    def self.oauth_secret=(val); @@oauth_secret=val; end


    # Call setup to set global defaults
  def self.setup
    yield self
  end
end

require 'twitter-vine/client'
