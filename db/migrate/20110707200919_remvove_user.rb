class RemvoveUser < ActiveRecord::Migration
  def up
    drop_table :users
  end

  def down
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.string :name
      t.string :role
      t.integer :sign_in_count
      t.string :image
      t.string :crop_params, :limit => 1024
      t.timestamps

    end
  end
end
