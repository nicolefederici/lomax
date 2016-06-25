class Lomax::Recording
attr_accessor :title, :contributors, :date 

  def initialize(title,contributors,date)
    @title = title
    @contributors = contributors
    @date = date
    
  end

  def split_recording(title)
    = self.title.split("; ")

end