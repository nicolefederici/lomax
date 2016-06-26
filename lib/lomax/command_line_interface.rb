
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
    return recordings
  end

  # def find_song_name()
  #   #validate song title?
  #   recordings_for_allmusic_search = Lomax::Scraper.get_recordings(url)
  #   recordings_for_allmusic_search.each do |recordings_for_allmusic_search|
  #     return recording.title

  def valid_song_title?(title,joined_titles)
    title = title
    flag = true 
    while flag == true
      if joined_titles.include?(title)
        flag = false
      else
      puts "Please enter a valid song title."
      title = gets.strip
      end
    end
    return title
  end

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
    nonce_list
    puts " Hey! You are at the Library of Congress' Alan Lomax Collection of Michigan Recordings! Here's a list of the Michigan cities from which Mr.Lomax collected recordings. Type the name of a city to view all the recordings he made there."
    puts 
    puts
    
    valid = nil
    while valid == nil
      valid = user_validation
      if valid != nil
      recordings = display_recordings(valid[:url])
      titles_array = recordings.collect do|recording| 
        recording.title
      end
      joined_titles = titles_array.join(",")
        # NEw Methods-- ##pick_song and ##scrape_all_music and ##display_all_music here is where I want to ask if user wants pick a song from this list to see if anyone in the world recorded it professionally at any point? (if I wanted to get cute, I'd add a youtube and vimeo scraper to see if anyone recorded it in their living room) I might need a Song class to process all songs as individual entities, and kind of batch put them through AllMusic by State or something, so the program can return all songs that have not yet been recorded anywhere but by the Lomaxes.
#optional text about your new options
#OPTIONAL METHOD---- get all musc recordings
    #getsing
puts "wanna see if anyone else recorded any of those songs professionally? I can check All Music's archive of recordings for you and return all the artists who professionally recorded a version of that song, including the first time that artist recorded it, the album it appeared on and its label, plus the year it was recorded by that artist. Just type in the name of a song you want to investigate."
  

  title = gets.strip

  title = valid_song_title?(title,joined_titles) 
    
   all_music_return = Lomax::Scraper.get_all_music_songs_of(title)
    #returns song hashes array with all the stuff anyone wants to know about other recordings.
    if all_music_return.length == 0
      puts "the Lomax field recording is the only known recording of this tune, at least according to All Music."
    else
      all_music_return.sort_by! {|hash| hash[:year]}
      all_music_return.each do |item|
      puts "\ntitle: '#{item[:title]}'\nperformers: #{item[:performers]}\ncomposers: #{item[:composers]}\nyear recorded: #{item[:year]}\nalbum: #{item[:album]}\nlabel: #{item[:label]}\n"
      end
    end

  #maybe put an option to choose another song from that city

      else 
        puts "Alan Lomax didn't record anything in that city, at least not according to the Library of Congress' Collections. Choose a city from the list this time."
      end
    end

        
    see_recordings_other_city?

  end

 

  def see_recordings_other_city? 
    
    puts "Would you like to see the recordings from another city in Michigan?"
    puts

    answer = gets.chomp

    if answer == "yes" || answer == "Yes"
      
      run
    
    else
     
     puts "Come back any time you'd like to check out this archive. See ya later!"
    end
  end

  def nonce_list
    places = Lomax::Scraper.get_places
    places.each do |place| 
      url = place[:url]
      recordings = Lomax::Scraper.get_recordings(url)
      recordings.each do |recording|
        title_array = recording.split_recording
        title_array.each do |title_string|
          nonce = Lomax::Scraper.get_li_s(title_string)
          if nonce == true
            puts place[:name] + "  '#{title_string}'"
        
          end
        end
      end
    end
  end



end
  

