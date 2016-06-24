#require_relative 'recording.rb'
require 'open-uri'
require 'nokogiri'

class Scraper

  def self.get_places
    doc = Nokogiri::HTML(open('https://www.loc.gov/collections/alan-lomax-in-michigan/index/location/'))
    places_array = []
    doc.css(".index li").each do |item|
      city_hash = {}
      city_hash[:name] = item.css("span.label").text
      city_hash[:count] = item.css("span.count").text
      city_hash[:url] = "https:" + item.css("a")[0]["href"]
      places_array << city_hash
    end
    places_array.delete_if { |hash| hash[:name] == "United States" || hash[:name] == "Michigan" || hash[:name] == "Illinois" || hash[:name] == "Chicago" || hash[:name] == "Wisconsin"}
    return places_array
  end

  def self.get_recordings(url)
    doc = Nokogiri::HTML(open(url + "&c=150&st=list"))
    recordings_array = []
    doc.css(".search-results.list-view li").each do |item|
      title = item.css("div.description h2 a").text.strip
      contributors = item.css("ul li.contributor span").text.strip
      date = item.css("ul li.date span").text.strip
      recordings_array << Recording.new(title,contributors,date)
    end
    return recordings_array
  end

end