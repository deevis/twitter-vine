require 'open-uri'

module TwitterVine
  module Client
    DEBUG = false

    #
    # OPTIONS:
    #           :api_key      (required)
    #           :api_secret   (required)
    #           :oauth_token  (required)
    #           :oauth_secret (required) 
    #           :count        (optional - default: 10)
    #           :lang         (optional - default: "en")
    #
    def self.search(q, opts={})
      # Always use a new client for Thread safety - is this necessary?
      tc = ::Twitter::REST::Client.new do |config|
        config.consumer_key        = opts.delete(:api_key) || TwitterVine.api_key
        config.consumer_secret     = opts.delete(:api_secret) || TwitterVine.api_secret
        config.access_token        = opts.delete(:oauth_tokn) || TwitterVine.oauth_key
        config.access_token_secret = opts.delete(:oauth_secret) || TwitterVine.oauth_secret
      end
      opts[:include_entities] = true
      opts[:lang] ||= "en"
      opts[:count] ||= 10
      vine_criteria = "\"vine.co/v/\" #{q} -RT"
      puts "Using search criteria [#{vine_criteria}]" if DEBUG
      _normalize(tc.search(vine_criteria, opts))
    end

    private
      # Does the processing inplace...
      def self._normalize(results) 
        results.entries.map do |r|
          vine_url = r.urls.map do |u| 
            if u[:display_url] =~ /vine\.co\/v/
              u[:expanded_url].to_s
            end
          end.compact.first
          doc = Nokogiri::HTML(open(vine_url))
          {
            time: r.created_at,
            id: r.id,
            url: r.url.to_s,
            author_id: r.user.id,
            author: r.user.name,
            screenname: r.user.screen_name,
            author_thumbnail: r.user.profile_image_url.to_s.gsub("normal","bigger"),
            text: r.text, 
            friends_count: r.user.friends_count,
            followers_count: r.user.followers_count,
            # media: r.media.map{|m| m.media_uri.to_s},
            vine_url: vine_url,
            vine_author_thumbnail: doc.css(".avatar-container img").first[:src],
            vine_author: doc.css("p.username").text,
            vine_description: doc.css("p.description").text.gsub(/\s+/," ").strip,
            vine_src: doc.css("video source").first[:src],
            vine_type: doc.css("video source").first[:type]
          }
        end 
      end

  end
end

