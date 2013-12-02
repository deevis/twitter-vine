# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "twitter-vine/version"

Gem::Specification.new do |s|
  s.name        = "twitter-vine"
  s.version     = TwitterVine::VERSION
  s.authors     = ["Darren Hicks"]
  s.email       = ["darren.hicks@gmail.com"]
  s.homepage    = "https://github.com/deevis/twitter-vine"
  s.summary     = "A simple API to search and retrieve information about Vines"
  s.description = "Uses the existing Twitter API and Nokogiri to get the job done"

  # s.rubyforge_project = "linkser"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # Gem dependencies
  #
  s.add_runtime_dependency('twitter', '~>5.1.1')
  s.add_runtime_dependency('nokogiri', '>= 1.6.0')

  # Specs
  s.add_development_dependency('rspec', '>= 2.14.1')
end
