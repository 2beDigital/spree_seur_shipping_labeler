# encoding: UTF-8
Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_seur_shipping_labeler'
  s.version     = '1.2.0'
  s.summary     = 'Spree Seur Extension for providing shipping and labels for Seur shipments'
  s.description = 'Spree Seur Extension for providing shipping and labels for Seur shipments'
  s.required_ruby_version = '>= 1.9.3'
  s.author    = 'Héctor Picazo, Noel Díaz, 2bedigital'
  s.homepage  = 'http://www.2bedigital.com'

  #s.files       = `git ls-files`.split("\n")
  #s.test_files  = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'

  s.add_dependency 'spree_core', '~> 2.4.10'
  s.add_dependency 'savon', '>= 2.11.1'
  s.add_dependency 'gyoku', '~> 1.0'

  s.add_development_dependency 'capybara', '~> 2.4'
  s.add_development_dependency 'coffee-rails'
  s.add_development_dependency 'database_cleaner'
  s.add_development_dependency 'factory_girl', '~> 4.5'
  s.add_development_dependency 'ffaker'
  s.add_development_dependency 'rspec-rails',  '~> 3.1'
  s.add_development_dependency 'sass-rails', '~> 4.0.2'
  s.add_development_dependency 'selenium-webdriver'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'sqlite3'

end
