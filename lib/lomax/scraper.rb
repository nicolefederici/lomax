require 'open-uri'
require 'nokogiri'

class Lomax::Scraper

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
      recordings_array << Lomax::Recording.new(title,contributors,date)
    end
    return recordings_array
  end
  # #def split_record
  # end
  # need a method that splits the title of the Lomax records, because sometimes, these things are three songs in one record, some with no titles
#---------------------------------
  #I want a method ##get_songs that scrapes the AllMusic page for each song in the Lomax Archive and returns either "nothing" or all the artists who recorded that song, and all the recoring dates, album titles, and labels. Here are the selectors I found:

  #year selector = tbody tr td.year (this is an array- iterate over them, and spit out each item by .texting them, and then .stripping them, which will leave you with the year)
  # album title selector = tbody tr td.artist-album div.title a
  # label selector = tbody tr td.label   

  #so this method will take in the url from the get songs method (see below) and do all of the above selectors on it. and return 


  def self.get_all_music_songs_of(title_string)
    
    title = title_string.split(" ").join("+")
    title = title.gsub(/'/, "%27")
    title = title.gsub(/,/, "%2C")
    title = title.gsub(/!/, "%21")
    title = title.gsub(/"/, "%22")
    title = title.gsub(/&/, "%26")
    title = title.gsub(/-/, "%2D")
    title = title.gsub(/\)/, "%29")
    title = title.gsub(/\(/, "%28")
    title = title.gsub(/\//, "%2F")
    title = title.gsub(/\?/, "%3F")
    title = title.gsub(/:/, "%3A")
    title = title.gsub(/\[/, "%5B")
    title = title.gsub(/\]/, "%5D")

  doc = Nokogiri::HTML(open("http://www.allmusic.com/search/songs/" + title))
  song_hashes_array = []
  #this is an array of hashes
  doc.css("li.song").each do |item|
      professional_recordings_hash = {}
      performers = item.css("div.performers a").text.strip
      composers = item.css("div.composers a").text.strip
      url = item.css("div.title a")[0]["href"]
      
      #this is the trick for grabbing hfrefs out of the a tags- url is part of the actual tag, so when you select the a tag, you get an array and then you grab the first and only item of the array with [0], and then you ask for the value of the href attr., which is hash notation, in other words, even though div.title a[0] is an array with one thing in it- the url, we still have to use hash notation to access the actual url only, because nokogiri uses hash notation to model the attributes and values in html tags. ******** href is the key, and the url is the value of that key, so if we only want the url stuff, we need to give it the key so it spits out the value for us with no other bullshit.
      #because you have to grab infor from within the tag itself with the hrefs.
      professional_recordings_hash = self.year_album_label(url)
      professional_recordings_hash[:performers] = performers
      professional_recordings_hash[:composers] = composers
      professional_recordings_hash[:url] = url

      song_hashes_array << professional_recordings_hash
    end
      return song_hashes_array
  end
  #this method should take in the url for each song return the year, album title, and label 
  

  def self.year_album_label(url)
    
    doc = Nokogiri::HTML(open(url))
    hash = {} 
    year = doc.css("tbody tr td.year")[0].text.strip
    album = doc.css("td.artist-album div.title a")[0].text.strip
    label = doc.css("tbody tr td.label")[0].text.strip
    hash[:year] = year
    hash[:album] = album
    hash[:label] = label
    
    return hash 
  end



 
  end






