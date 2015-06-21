require 'twitter-vine/version'
require 'twitter'
require 'nokogiri'
require 'twitter-vine/client'

module TwitterVine
  DEBUG = false

  def self.parse(vine_url)
    vine_url.gsub!("http://", "https://")
    vine_url.gsub!("/embed/simple", "")
    puts "Got vine_url [#{vine_url}]" if DEBUG
    begin
      doc = Nokogiri::HTML(open(vine_url))
    rescue OpenURI::HTTPError
      return nil
    end
    hashtag_regex = /#([A-Za-z0-9]+)/
    parsed_vine = {
        vine_id: vine_url.match(/.*\/(.*)/)[1],
        vine_url: vine_url,
        vine_text: doc.xpath("//div")[0].children[1].children[1].children[3].children[10].children[0].text,
        vine_thumbnail: doc.xpath("//meta[@property='og:image']").first[:content],
        vine_author_thumbnail: doc.css("article.post a img").first["src"],
        vine_author_profile_url: "https://vine.co" + doc.xpath("//a").last.attributes["href"].value,
        vine_author: doc.xpath("//a").last.children[3].children[0].text,
        vine_description: doc.xpath("//meta[@property='og:description']").first[:content],
        vine_src: doc.xpath("//meta[@property='twitter:player:stream']").first[:content],
        vine_type: doc.xpath("//meta[@property='twitter:player:stream:content_type']").first[:content].split(";").first
    }
    parsed_vine[:vine_hashtags] = parsed_vine[:vine_text].scan(hashtag_regex).flatten

    parsed_vine
  end
end
