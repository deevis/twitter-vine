require 'twitter-vine/version'
require 'twitter'
require 'nokogiri'

module TwitterVine
  DEBUG = false

  def self.parse(vine_url)
    vine_url.gsub!("http://", "https://")
    vine_url.gsub!("/embed/simple", "")
    puts "Got vine_url [#{vine_url}]" if DEBUG
    doc = Nokogiri::HTML(open(vine_url))
    {
        vine_id: vine_url.match(/.*\/(.*)/)[1],
        vine_url: vine_url,
        vine_thumbnail: doc.xpath("//meta[@property='og:image']").first[:content],
        vine_author_thumbnail: doc.css(".avatar-container img").first[:src],
        vine_author: doc.css("p.username").text,
        vine_description: doc.css("p.description").text.gsub(/\s+/," ").strip,
        vine_src: doc.css("video source").first[:src],
        vine_type: doc.css("video source").first[:type]
    }
  end
end
