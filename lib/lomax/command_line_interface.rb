class Lomax::CommandLineInterface

  def display_places
    places = Lomax::Scraper.get_places
    places.each do |place| 
      puts place.name
    end
    puts
    puts
  end

  def display_recordings(place)
    puts
    puts
    list_of_recordings = []
    recordings = Lomax::Scraper.get_recordings(place)
    recordings.each do |recording|
      puts recording.title, recording.date
      puts recording.contributors, recording.place.name
      puts
      puts
    end
    return recordings
  end

  def valid_song_title?(title,joined_titles)
    #title = title
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
    places_array = Lomax::Place.all 
    choice = places_array.detect do |place|
      place.name == city_answer
    end
    return choice
  end



  def run
    puts
    puts "Hey! You're at the Library of Congress' Alan Lomax Collection of Michigan Recordings!" 
    puts
    puts"Here's a list of the Michigan cities from which Mr.Lomax collected recordings." 
    puts
    puts"Type the name of a city to view all the recordings he made there."
    puts 
    puts
    
    flag = nil
    while flag == nil #these two lines basically say, "if everything remians as it now is..."
      flag = user_validation
      if flag != nil
        recordings = display_recordings(flag)
        titles_array = recordings.collect do|recording| 
          recording.title
        end
        joined_titles = titles_array.join(",")
          
        puts 
        puts
        puts"Would you like to see if there are any other available recordings of this song on record?"
        puts
        puts "I can access All Music's archive to return all the other known recordings of that song, including the  artist(s) who recorded it, the album and label it first appeared on, and the year it was first recorded by that artist. And I'll do it in chronological order." 
        puts
        puts "Type the name of a song you want to investigate, or type no, if you want to return to the beginning."
        puts
    
        title = gets.strip

        if title == "no" || title == "no"
          run
        else

          title = valid_song_title?(title,joined_titles) 
        
          all_music_return = Lomax::Scraper.get_all_music_songs_of(title)
        #returns song hashes array with all the stuff anyone wants to know about other recordings.
        
          if all_music_return.length == 0
            puts
            puts "Alan Lomax's field recording is the only available recording of this tune."
            puts
          else
            all_music_return.sort_by! {|hash| hash[:year]}
            all_music_return.each do |item|
            puts "\ntitle: '#{item[:title]}'\nperformers: #{item[:performers]}\ncomposers: #{item[:composers]}\nyear recorded: #{item[:year]}\nalbum: #{item[:album]}\nlabel: #{item[:label]}\n"
            end
          end
        end

  # maybe make an option to choose another song from that city?

      else 
        puts "Alan Lomax didn't record anything in that city, at least not according to the Library of Congress' Collections. Choose a city from the list this time."
      end
    end
        
    see_recordings_other_city?

  end


  def nonce_list
    places = Lomax::Place.all
    places.each do |place| 
      recordings = Lomax::Scraper.get_recordings(place)
      recordings.each do |recording|
        title_array = recording.split_recording
        title_array.each do |title_string|
          nonce = Lomax::Scraper.get_li_s(title_string)
          if nonce == true
            puts place.name + "  '#{title_string}'"
        
          end
        end
      end
    end
  end 

  def see_recordings_other_city? 
    puts
    puts
    puts "Would you like to see the recordings from another city in Michigan?"
    puts

    answer = gets.chomp

    if answer == "yes" || answer == "Yes"      
      run    
    else     
      puts "Before you go, would you like to see a list of all the nonce songs (songs of which this field recording is the only likely recording ever made) in the Alan Lomax Collection of Michigan Recordings?"

      answer = gets.chomp
      if answer == "yes" || answer == "Yes"     
       nonce_list
      end
      puts
      puts "See you next time, and keep singing!"
    
    end
  end

end
  