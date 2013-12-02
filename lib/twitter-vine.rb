require 'twitter-vine/version'
require 'twitter'
require 'nokogiri'

module TwitterVine
    DEBUG = false

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

  def self.build_vine_map(twitter_result)
    vine_url = twitter_result.urls.map do |u| 
        if u[:display_url] =~ /vine\.co\/v/
          u[:expanded_url].to_s
        end
    end.compact.first
    puts "Got vine_url [#{vine_url}]" if DEBUG
    doc = Nokogiri::HTML(open(vine_url))
    {
        vine_id: vine_url.match(/.*\/(.*)/)[1],
        vine_url: vine_url,
        vine_author_thumbnail: doc.css(".avatar-container img").first[:src],
        vine_author: doc.css("p.username").text,
        vine_description: doc.css("p.description").text.gsub(/\s+/," ").strip,
        vine_src: doc.css("video source").first[:src],
        vine_type: doc.css("video source").first[:type]
    }

  end
end

require 'twitter-vine/client'
