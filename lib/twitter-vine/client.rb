require 'open-uri'

module TwitterVine
  module Client
    def self.api_key; @@api_key; end
    def self.api_key=(val); @@api_key=val; end

    def self.api_secret; @@api_secret; end
    def self.api_secret=(val); @@api_secret=val; end

    def self.oauth_token; @@oauth_token; end
    def self.oauth_token=(val); @@oauth_token=val; end

    def self.oauth_secret; @@oauth_secret; end
    def self.oauth_secret=(val); @@oauth_secret=val; end


    # Call setup to set global defaults for api_key, api_secret, oauth_token and oauth_secret
    def self.setup
      yield self
    end

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
        config.consumer_key        = opts.delete(:api_key) || api_key
        config.consumer_secret     = opts.delete(:api_secret) || api_secret
        config.access_token        = opts.delete(:oauth_token) || oauth_token
        config.access_token_secret = opts.delete(:oauth_secret) || oauth_secret
      end
      opts[:include_entities] = true
      opts[:lang] ||= "en"
      opts[:count] ||= 10
      vine_criteria = "\"vine.co/v/\" #{q} -RT"
      puts "Using search criteria [#{vine_criteria}]" if TwitterVine::DEBUG
      _normalize(tc.search(vine_criteria, opts))
    end

    private
      # Does the processing inplace...
      def self._normalize(results) 
        results.to_h[:statuses].map do |r|
          puts r
          vine_map = build_vine_map(r)
          #puts "...mapping...#{r[:entities][:media]}"
          {
            time: (Time.parse(r[:created_at]) rescue Time.now),
            id: r[:id],
            url: "https://twitter.com/#{r[:user][:screen_name]}/status/#{r[:id]}",
            author_id: r[:user][:id],
            author: r[:user][:name],
            screenname: r[:user][:screen_name],
            author_thumbnail: r[:user][:profile_image_url].gsub("normal","bigger"),
            bg_color: r[:user][:profile_background_color],
            text_color: r[:user][:profile_text_color],
            text: r[:text], 
            friends_count: r[:user][:friends_count],
            followers_count: r[:user][:followers_count],
            #media: r.media.map{|m| m.media_uri.to_s}
            #media: (r[:entities][:media].map{|m| m[:media_url]} rescue [])
          }.merge(vine_map)
        end.compact
      end

      def self.build_vine_map(twitter_result)
        vine_url = twitter_result[:entities][:urls].map do |u| 
            if u[:display_url] =~ /vine\.co\/v/
              u[:expanded_url].to_s
            end
        end.compact.first
        TwitterVine.parse(vine_url)
      end

  end
end

