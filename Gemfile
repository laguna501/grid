source 'http://rubygems.org'

gem 'rails', '3.2.6'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails'
  gem 'coffee-rails'
  gem 'uglifier'
end

gem 'cancan'
gem 'capistrano'
gem 'jquery-rails'
gem 'mysql2'
gem 'fb_graph'
gem 'syslog-logger'
gem 'unicorn'

group :development, :test, :staging do
  # Pretty printed test output
  gem 'factory_girl_rails'
  gem 'mocha', require: 'mocha_standalone'
  gem 'parallel_tests'
  gem 'railroady'
  gem 'rspec-rails'
  gem 'capybara'
  gem 'database_cleaner'
end

group :ubuntu do
  gem 'therubyracer'
end
