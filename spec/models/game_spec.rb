require 'spec_helper'

RSpec.describe Game do

  describe "a new game" do
    let(:game) { Game.new }
    it "should generate a board using defaults when started" do
      game.start
      expect(game.board.length).to eq(Game::TILES)
      expect(game.red_spies.length + game.blue_spies.length).to eq(2 * Game::SPIES + 1)
    end
  end

  describe "a game" do
    let(:game) { Game.new.setup(5, 1, Random.new(1)) }
    # should produce
    # 0. aunt - bystander
    # 1. drawer - blue
    # 2. birth - red
    # 3. title - blue
    # 4. stop - assassin

    it "should have 2 blue spies" do
      expect(game.blue_spies.length).to eq(2)
    end

    it "should have 1 red spy" do
      expect(game.red_spies.length).to eq(1)
    end

    it "should let the blue team go first" do
      expect(game.first_team).to eq(:blue)
    end

    describe "when started" do
      before do
        game.start
      end

      it "should transition to the correct state when starting" do
        expect(game).to be_blue_turn
      end

      it "should switch teams when ending a turn" do
        game.end_turn
        expect(game).to be_red_turn
        game.end_turn
        expect(game).to be_blue_turn
      end

      it "should give the win to the other team when losing" do
        game.lose
        expect(game).to be_red_wins
      end

      it "should take the win when winning" do
        game.win
        expect(game).to be_blue_wins
      end

      it "should lose the game when revealing the assassin" do
        game.reveal(4)
        expect(game).to be_red_wins
        expect(game.board[4][:revealed]).to eq(true)
      end

      it "should end the turn when revealing a bystander" do
        game.reveal(0)
        expect(game).to be_red_turn
        expect(game.board[0][:revealed]).to eq(true)
      end

      it "should end the turn when revealing an opponent's spy" do
        game.end_turn
        game.reveal(1)
        expect(game).to be_blue_turn
        expect(game.board[1][:revealed]).to eq(true)
      end

      it "should allow the team to continue if they reveal their own team's spy" do
        game.reveal(1)
        expect(game).to be_blue_turn
        expect(game.board[1][:revealed]).to eq(true)
      end

      it "should win the game when revealing all the current team's spies" do
        game.reveal(1)
        game.reveal(3)
        game.end_turn
        expect(game).to be_blue_wins
      end
    end
  end
end
