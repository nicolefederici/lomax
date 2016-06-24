class Lomax::Recording
attr_accessor :title, :contributors, :date 

  def initialize(title,contributors,date)
    @title = title
    @contributors = contributors
    @date = date
    
  end

end