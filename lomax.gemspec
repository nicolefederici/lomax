# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'lomax/version'

Gem::Specification.new do |spec|
  spec.name          = "lomax"
  spec.version       = Lomax::VERSION
  spec.authors       = ["nicolefederici"]
  spec.email         = ["nicolefederici@yahoo.com"]

  spec.summary       = "Explores the Alan Lomax Collection of Michigan Songs and checks its collection for novel recordings against the records of AllMusic "
  spec.description   = "This gem uses a command line interface to access the Alan Lomax Archive of Michigan Songs, a collection of field recordings of folk music sung by regular people, to display the songs they collected on their Michigan trip. Through this gem, the user can compare the songs in this archive to the complete AllMusic collection of the known recorded music throughout history, in order to discover which of the Lomax recordings were never otherwise recorded." 
  spec.homepage      = "https://github.com/nicolefederici/lomax"
  spec.license       = "MIT"

  if spec.respond_to?(:metadata)
  spec.metadata['allowed_push_host'] = "http://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry", "~> 0.10.0"
  spec.add_dependency "nokogiri", '~> 1.6', '>= 1.6.6.2'
end
