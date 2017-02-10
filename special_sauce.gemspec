$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "special_sauce/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "special_sauce"
  s.version     = SpecialSauce::VERSION
  s.authors     = ["Eric Arnold"]
  s.email       = ["earnold@covermymeds.com"]
  s.homepage    = "https://github.com/nativestranger/special_sauce"
  s.summary     = "SpecialSauce helps you run your Capybara or Watir tests with Sauce Labs."
  s.description = "SpecialSauce helps you run your Capybara or Watir tests with Sauce Labs."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_development_dependency "rails", '>= 4.1.0'
  s.add_development_dependency "sqlite3"
  s.add_development_dependency "appraisal"
end
