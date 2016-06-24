
require 'nokogiri'


class Lomax::CommandLineInterface

  def display_places
    places = Lomax::Scraper.get_places
    places.each do |place| 
      puts place[:name]
    end
  end

  def display_recordings(url)
    list_of_recordings = []
    recordings = Lomax::Scraper.get_recordings(url)
    recordings.each do |recording|
    puts recording.title, recording.date, recording.contributors
    end
  end



  def user_validation
    display_places
    city_answer = gets.chomp #it is a string
    places_array = Lomax::Scraper.get_places 
    choice = places_array.detect do |place|
      place[:name] == city_answer
    end
    return choice
  end



  def run
    
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
    
    puts "Would you like to see the recorings from another city in Michigan?"

    answer = gets.chomp

    if answer == "yes" || answer == "Yes"
      
      run
    
    else
      puts "Come back any time you'd like to check out this archive. See ya later!"
    end
  end
end