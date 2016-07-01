class Lomax::Scraper

  def self.get_places
    doc = Nokogiri::HTML(open('https://www.loc.gov/collections/alan-lomax-in-michigan/index/location/'))
    places_array = []
    doc.css(".index li").each do |item|
      name = item.css("span.label").text
      count = item.css("span.count").text
      url = "https:" + item.css("a")[0]["href"]
      if name != "United States" && name != "Michigan" && name != "Illinois" && name != "Chicago" && name != "Wisconsin"
        places_array << Lomax::Place.new(name,count,url)
      end
    end
    return places_array
  end

  def self.get_li_s(title_string) #this method returns true if it is a nonce song.
    title = title_string.split(" ").join("+")
    doc = Nokogiri::HTML(open(URI.escape("http://www.allmusic.com/search/songs/" + title)))
    array = doc.css("li.song")
    if array.length == 0
      return true
    else
      return false
    end
  end

  def self.get_recordings(place)
    doc = Nokogiri::HTML(open(place.url + "&c=150&st=list"))
    recordings_array = []
    doc.css(".search-results.list-view > li").each do |item|
      title = item.css("div.description h2 a").text.strip
      contributors = item.css("ul li.contributor span").text.strip
      date = item.css("ul li.date span").text.strip
      recordings_array << Lomax::Recording.new(title,contributors,date,place)
      end
      place.recordings = recordings_array
    
    return recordings_array
  end
   


  def self.split_composers_performers(array)
    new_array = []
    array.each do |item|
      new_array << item.text.strip
    end
    hey = new_array.join(", ")
    return hey
  end


  

  def self.get_all_music_songs_of(title_string)
      
    title = title_string.split(" ").join("+")
    doc = Nokogiri::HTML(open(URI.escape("http://www.allmusic.com/search/songs/" + title)))
    song_hashes_array = []
    #this is an array of hashes
    doc.css("li.song").each do |item|
      professional_recordings_hash = {}
      performers = item.css("div.performers a")#.text.strip
      perf = self.split_composers_performers(performers)
      composers = item.css("div.composers a")#.text.strip
      comp = self.split_composers_performers(composers)
      url = item.css("div.title a")[0]["href"]
      
      #this is the trick for grabbing hfrefs out of the a tags- url is part of the actual tag, so when you select the a tag, you get an array and then you grab the first and only item of the array with [0], and then you ask for the value of the href attr., which is hash notation, in other words, even though div.title a[0] is an array with one thing in it- the url, we still have to use hash notation to access the actual url only, because nokogiri uses hash notation to model the attributes and values in html tags. ******** href is the key, and the url is the value of that key, so if we only want the url stuff, we need to give it the key so it spits out the value for us with no other bullshit, because you have to grab info from within the tag itself with the hrefs.
      
      professional_recordings_hash = self.year_album_label(url)
      professional_recordings_hash[:title] = title_string
      professional_recordings_hash[:performers] = perf
      professional_recordings_hash[:composers] = comp
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






