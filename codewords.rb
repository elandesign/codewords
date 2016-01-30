class Codewords < Sinatra::Base
  set :root, Pathname.new(File.dirname(__FILE__)).expand_path
  set :public_folder => "public", :static => true

  get "/" do
    send_file "views/index.html"
  end

  get "/games" do
    Game.playing.to_json(only: [:id, :teams])
  end

  get "/games/:id/:key" do
    game = Game.find(params[:id])
    if params[:key] == game.spymaster
      game.to_json(:spymaster)
    elsif params[:key] == game.teams
      game.to_json
    else
      raise ActiveRecord::RecordNotFound
    end
  end
end
