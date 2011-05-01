class AddHeaderToPage < ActiveRecord::Migration
  def self.up
    add_column :pages, :header, :string
  end

  def self.down
    remove_column :pages, :header
  end
end
