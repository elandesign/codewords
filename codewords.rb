class Codewords < Sinatra::Base
  set :root, Pathname.new(File.dirname(__FILE__)).expand_path
  set :public_folder => "public", :static => true

  get "/" do
    send_file "views/index.html"
  end
end
