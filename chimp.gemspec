Gem::Specification.new do |s|
  s.name              = "chimp"
  s.version           = "0.0.2"
  s.summary           = "Lightweight mailchimp client"
  s.description       = "For those who want something nimble."
  s.authors           = ["Cyril David"]
  s.email             = ["me@cyrildavid.com"]
  s.homepage          = "http://github.com/cyx/chimp"

  s.files = Dir[
    "LICENSE",
    "README",
    "rakefile",
    "lib/**/*.rb",
    "*.gemspec",
    "test/*.*"
  ]

  s.add_development_dependency "dep"
  s.add_development_dependency "cutest"
end
