class RemovePictureFromUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :picture, :string
  end
end
