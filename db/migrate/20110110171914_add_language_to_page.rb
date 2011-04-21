class AddLanguageToPage < ActiveRecord::Migration
  def self.up
    add_column :pages, :language, :string
    add_column :blogs, :language, :string
    add_column :comments, :language, :string
    add_column :illustrations, :language, :string
  end

  def self.down
    remove_column :pages, :language
    remove_column :blogs, :language
    remove_column :comments, :language
    remove_column :illustrations, :language
  end
end
