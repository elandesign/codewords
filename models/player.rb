class Player < ActiveRecord::Base
  belongs_to :game
  enum team: [:red, :blue]
end
