class AddLableToPage < ActiveRecord::Migration
  def self.up
    remove_column :pages, :header
    add_column :pages, :identity, :string
  end

  def self.down
    remove_column :pages, :identity
    add_column :pages, :header, :string
  end
end
