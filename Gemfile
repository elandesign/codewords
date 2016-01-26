source "https://rubygems.org/"

# App Stack
gem "sinatra", "~> 1.4"

# Database Stack
gem 'activerecord', '>= 3.1', :require => 'active_record'
gem "sqlite3"
gem "aasm"

group :development do
  gem "foreman"
  gem "rake", "~> 10.0"
  gem "rspec"
  gem "rack-test", "~> 0.6"
  gem "capybara"
end

group :test do
  gem "database_cleaner"
end

group :development, :test do
  gem 'pry-byebug'
end
