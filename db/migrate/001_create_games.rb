class CreateGames < ActiveRecord::Migration
  def self.up
    create_table :games do |t|
      t.text :words
      t.string :state
      t.integer :red_spymaster, :blue_spymaster
      t.timestamps
    end
  end

  def self.down
    drop_table :games
  end
end
