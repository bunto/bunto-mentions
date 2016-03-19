Gem::Specification.new do |s|
  s.name        = "bunto-mentions"
  s.summary     = "@mention support for your Bunto site"
  s.version     = "1.0.0"
  s.authors     = ["GitHub, Inc."]
  s.email       = "support@github.com"

  s.homepage    = "https://github.com/bunto/bunto-mentions"
  s.licenses    = ["MIT"]
  s.files       = [ "lib/bunto-mentions.rb" ]

  s.add_dependency "bunto", '~> 1.0'
  s.add_dependency "html-pipeline", '~> 2.3'

  s.add_development_dependency 'rake'
  s.add_development_dependency 'rdoc'
  s.add_development_dependency 'rspec', '~> 3.0'
end
