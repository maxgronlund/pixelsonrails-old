class CreateCases < ActiveRecord::Migration
  def self.up
    create_table :cases do |t|
      t.string :title
      t.text :body
      t.string :category

      t.timestamps
    end
  end

  def self.down
    drop_table :cases
  end
end
