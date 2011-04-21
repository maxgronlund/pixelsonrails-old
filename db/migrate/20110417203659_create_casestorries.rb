class CreateCasestorries < ActiveRecord::Migration
  def self.up
    create_table :casestorries do |t|
      t.string :title
      t.text :body
      t.string :category

      t.timestamps
    end
  end

  def self.down
    drop_table :casestorries
  end
end
