class CreateIllustrations < ActiveRecord::Migration
  def self.up
    create_table :illustrations do |t|
      t.string :title
      t.timestamps
    end
  end

  def self.down
    drop_table :illustrations
  end
end
