require_relative "./lomax/version.rb"
require_relative "./lomax/scraper.rb"
require_relative "./lomax/recording.rb"
require_relative "./lomax/command_line_interface.rb"
require_relative "./lomax/place.rb"
require 'nokogiri'
require 'pry'
require 'open-uri'
require 'uri'

module Lomax
  # Your code goes here...(this came with the gem bundle..not sure why this is here.)
end

#these are the gem's dependencies (nokogiri and pry), and the require relatives are what all has to activate together for the gem to work.
#they are all the classes called upon by the executable file.
# this is usually called the config file