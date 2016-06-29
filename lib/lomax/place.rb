class Lomax::Place

  attr_accessor :name, :count, :url, :recordings
  @@all = []

  def initialize(name,count,url)
    @name = name
    @count = count
    @url = url
    @recordings = []
    @@all << self

  end

  def self.all 
    @@all 
  end

end