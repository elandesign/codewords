class CreatePlayers < ActiveRecord::Migration
  def self.up
    create_table :players do |t|
      t.references :game
      t.string :name
      t.team :integer
      t.timestamps
    end
  end

  def self.down
    drop_table :players
  end
end
