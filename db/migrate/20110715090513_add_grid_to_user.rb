class AddGridToUser < ActiveRecord::Migration
  def change
    add_column :users, :grid, :boolean
  end
end
