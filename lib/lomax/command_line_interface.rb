
require 'nokogiri'


class Lomax::CommandLineInterface

  def display_places
    places = Lomax::Scraper.get_places
    places.each do |place| 
      puts place[:name]
    end
  end

  def display_recordings(url)
    puts
    puts
    list_of_recordings = []
    recordings = Lomax::Scraper.get_recordings(url)
    recordings.each do |recording|
    puts recording.title, recording.date, recording.contributors
    end

  end

  def find_song_name()
    recordings_for_allmusic_search = Lomax::Scraper.get_recordings(url)
    recordings_for_allmusic_search.each do |recordings_for_allmusic_search|
      return recording.title


  def user_validation
    puts
    display_places
    city_answer = gets.chomp #it is a string
    places_array = Lomax::Scraper.get_places 
    choice = places_array.detect do |place|
      place[:name] == city_answer
    end
    return choice
  end



  def run
    # The user sees the list of places the Lomaxes recorded in Michigan, and chooses a town to examine. Next, the recordings made in that twon are displayed with : title, date, performers.
    #NEW_METHOD- They are then asked if they want to choose a song from these to see if anyone else professionally recorded that song. THey will answer yes and get taken to the list of recordings (with artist, year, album, and label) for that song in All Music. If there is no other recording, they will be told that no other recording exists. Next, they will be asked if they want to 1. return to the list of songs to choose another. 2. 3.
    puts " Hey! You are at the Library of Congress' Alan Lomax Collection of Michigan Recordings! Here's a list of the Michigan cities from which Mr.Lomax collected recordings. Type the name of a city to view all the recordings he made there."
    puts 
    puts
    
    valid = nil
    while valid == nil
      valid = user_validation
      if valid != nil
        display_recordings(valid[:url])
        # NEw Methods-- ##pick_song and ##scrape_all_music and ##display_all_music here is where I want to ask if user wants pick a song from this list to see if anyone in the world recorded it professionally at any point? (if I wanted to get cute, I'd add a youtube and vimeo scraper to see if anyone recorded it in their living room) I might need a Song class to process all songs as individual entities, and kind of batch put them through AllMusic by State or something, so the program can return all songs that have not yet been recorded anywhere but by the Lomaxes.
         
      else 
        puts "Alan Lomax didn't record anything in that city, at least not according to the Library of Congress' Collections. Choose a city from the list this time."
      end
    end

        
    next_meth

  end



  def next_meth 
    
    puts "Would you like to see the recordings from another city in Michigan?"
    puts

    answer = gets.chomp

    if answer == "yes" || answer == "Yes"
      
      run
    
    else
      puts "Come back any time you'd like to check out this archive. See ya later!"
    end
  end
end