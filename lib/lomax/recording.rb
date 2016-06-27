class Lomax::Recording
  attr_accessor :title, :contributors, :date 

  def initialize(title,contributors,date)
    @title = title
    @contributors = contributors
    @date = date
  end

  def split_recording
    separated_title = self.title.split("; ")
    return separated_title
    #this is an array
  end

end