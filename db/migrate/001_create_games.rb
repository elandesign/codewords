class CreateGames < ActiveRecord::Migration
  def self.up
    create_table :games do |t|
      t.string :state
      t.text :board
      t.string :spymaster, :teams
      t.timestamps null: false
    end
    add_index :games, :state
  end

  def self.down
    drop_table :games
  end
end
