require "yaml"
settings = YAML::load_file("config/database.yml")
# Sequel Configuration
ActiveRecord::Base.establish_connection(settings[ENV['RACK_ENV']])
