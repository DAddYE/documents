source 'https://rubygems.org'

# Project requirements
gem 'rake'

# Component requirements
gem 'slim'
gem 'pygments.rb', require: 'pygments'
gem 'redcarpet'

group :assets, :development do
  gem 'uglifier'
  gem 'coffee-script'
  gem 'bourbon'
  gem 'sprockets'
end

group :test do
  gem 'terminal-notifier-guard'
  gem 'rb-fsevent', require: false
  gem 'guard-minitest'
  gem 'nokogiri'
  gem 'minitest'
end

# Living on the Edge, ye yeye
gem 'padrino', path: '/usr/src/padrino/padrino-framework'
