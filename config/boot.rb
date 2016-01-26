ENV["RACK_ENV"] ||= "development"

require "bundler"
Bundler.require

require_relative "../codewords"

%w{config/initializers lib models}.each do |load_path|
  Codewords.root.join(load_path).find do |f|
    require f if f.fnmatch?("*.rb")
  end
end
