class Lomax::Recording
  attr_accessor :title, :contributors, :date, :place 

  def initialize(title,contributors,date,place)
    @title = title
    @contributors = contributors
    @date = date
    @place = place

  end

  def split_recording
    separated_title = self.title.split("; ")
    return separated_title
    #this is an array
  end


end