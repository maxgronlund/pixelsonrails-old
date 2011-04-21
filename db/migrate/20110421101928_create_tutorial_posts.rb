class CreateTutorialPosts < ActiveRecord::Migration
  def self.up
    create_table :tutorial_posts do |t|
      t.string :title
      t.text :body
      t.integer :tutorial_id

      t.timestamps
    end
  end

  def self.down
    drop_table :tutorial_posts
  end
end
