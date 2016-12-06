class Lomax::Place

  attr_accessor :name, :count, :url, :recordings
  @@all = []

  # def recordings
  #   @recordings
  # end

  # def recordings=(recordings)
  #   @recordings = recordings
  # end

  def initialize(name,count,url)
    @name = name
    @count = count
    @url = url
    @recordings = []
    @@all << self
  end

  # def capitalized_name
  #   name = "new name"
  #   @name.capitalize
  #   self.name.capitalize
  # end

  def self.all 
    @@all 
  end

end