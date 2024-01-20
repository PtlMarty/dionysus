class AddFirstNameAndLastNameToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :fisrt_name, :string
    add_column :users, :last_name, :string
  end
end
