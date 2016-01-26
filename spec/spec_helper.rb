ENV['RACK_ENV'] = 'test'

require 'bundler'

Bundler.setup
Bundler.require

# spec/spec_helper.rb
require 'rack/test'
require 'rspec'
require 'pry-byebug'
require 'database_cleaner'
require 'capybara/rspec'



require File.expand_path('../../config/boot.rb', __FILE__)

module RSpecMixin
  include Capybara::RSpecMatchers
  include Rack::Test::Methods
  def app() Codewords end
  def page() last_response.body end
end

RSpec.configure do |config|
  config.include RSpecMixin

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.append_after(:each) do
    DatabaseCleaner.clean
  end

end
