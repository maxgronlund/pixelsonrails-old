class AddBodyToUser < ActiveRecord::Migration
  def change
    add_column :users, :title, :string
    add_column :users, :body, :text
    add_column :users, :phone, :string
  end
end
