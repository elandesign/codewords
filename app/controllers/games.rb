Codewords::App.controllers :games do
  get :index, map: '/games' do
    @games = Game.in_progress
  end

  post :game do
    game = Game.new
    game.start!(Game::WORDS, Game::SPIES)
    game.to_json(only: [:id, :spymaster])
  end

  get :game, :with => :id do
    game = Game.find(params[:id])
  end
end
