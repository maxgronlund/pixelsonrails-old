class AddCropParamsToUser < ActiveRecord::Migration
  def change
    add_column :users, :crop_params, :string, :limit => 1024
  end
end
