class Game < ActiveRecord::Base
  include AASM

  BYSTANDER = 'bystander'
  RED_SPY = 'red'
  BLUE_SPY = 'blue'
  ASSASSIN = 'assassin'

  DICTIONARY = YAML.load_file(Pathname.new(Padrino.root).join("config", "words.yml"))
  TILES = 25
  SPIES = 8

  has_many :players
  serialize :board

  scope :in_progress, -> { where(state: [:red_turn, :blue_turn]) }

  aasm :turn, column: :turn do
    state :red_turn, initial: true
    state :blue_turn

    event :end_turn do
      transitions from: :red_turn, to: :blue_turn
      transitions from: :blue_turn, to: :red_turn

      before do
        if winner == :red
          red_wins
        elsif winner == :blue
          blue_wins
        end
      end
    end
  end

  aasm :state, column: :state do
    state :setup, initial: true
    state :playing
    state :red_wins
    state :blue_wins

    event :start do
      transitions from: :setup, to: :playing

      before do
        setup unless board.present?
      end
    end

    event :lose do
      transitions from: :playing, to: :red_wins, if: :blue_turn?
      transitions from: :playing, to: :blue_wins, if: :red_turn?
    end

    event :win do
      transitions from: :playing, to: :red_wins, if: :red_turn?
      transitions from: :playing, to: :blue_wins, if: :blue_turn?
    end

    event :red_wins do
      transitions from: :playing, to: :red_wins
    end

    event :blue_wins do
      transitions from: :playing, to: :blue_wins
    end
  end

  # Public: Has the red or blue team revealed all their spies?
  # 
  # Returns :red, :blue, or nil
  def winner
    if red_spies.all? { |x| x[:revealed] }
      :red
    elsif blue_spies.all? { |x| x[:revealed] }
      :blue
    else
      nil
    end
  end

  def reveal(x)
    tile = board[x]
    tile[:revealed] = true

    case tile[:type]
    when ASSASSIN
      lose!
    when BYSTANDER
      end_turn!
    when RED_SPY
      if blue_turn?
        end_turn!
      else
        save
      end
    when BLUE_SPY
      if red_turn?
        end_turn!
      else
        save
      end
    end
  end

  def red_spies
    board.select { |x| x[:type] == RED_SPY }
  end

  def blue_spies
    board.select { |x| x[:type] == BLUE_SPY }
  end

  # Public: Set up a new game
  # tiles - the number of tiles to create
  # spies - the number of spies on each team (+1 on the starting team)
  # seed - the random seed to use when selecting words
  # 
  # Returns nothing
  def setup(tiles = TILES, spies = SPIES, seed = Random.new)
    create_tiles(tiles, seed)
    tiles = (0..(tiles - 1)).to_a.shuffle(random: seed)
    set_spies(RED_SPY, tiles.shift(spies))
    set_spies(BLUE_SPY, tiles.shift(spies))
    set_spies([RED_SPY, BLUE_SPY].sample(random: seed), tiles.shift(1))
    set_spies(ASSASSIN, tiles.shift(1))
    self.spymaster = SecureRandom.urlsafe_base64
    self.teams = SecureRandom.urlsafe_base64
    self.turn = first_turn
    self
  end

  # Internal: Create a board with a random sampling of dictionary words
  # All tiles will be bystanders at this point
  # tiles - the number of tiles to create
  # seed - the random seed to use when selecting words
  # 
  # Returns nothing
  def create_tiles(tiles, seed = Random.new)
    words = DICTIONARY.sample(tiles, random: seed)
    self.board = []
    tiles.times do |i|
      board << {
        position: i,
        codeword: words.shift,
        type: BYSTANDER,
        revealed: false
      }
    end
  end

  # Internal: Set tiles at each position to be a spy
  # type - RED_SPY, BLUE_SPY or ASSASSIN
  # positions - an Array of indexes at which to set the spies
  # 
  # Returns nothing
  def set_spies(type, positions)
    positions.each do |x|
      board[x][:type] = type
    end
  end

  # Internal: Which team goes first?
  # 
  def first_turn
    if red_spies.length > blue_spies.length
      :red_turn
    else
      :blue_turn
    end
  end
end
