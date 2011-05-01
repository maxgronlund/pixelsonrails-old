class AddGridToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :grid, :boolean
  end

  def self.down
    remove_column :users, :grid
  end
end
