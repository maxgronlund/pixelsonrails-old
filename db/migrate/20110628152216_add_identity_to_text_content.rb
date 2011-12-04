class AddIdentityToTextContent < ActiveRecord::Migration
  def change
    add_column :text_contents, :identity, :string
  end
end
