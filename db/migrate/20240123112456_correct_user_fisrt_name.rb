class CorrectUserFisrtName < ActiveRecord::Migration[7.0]
  def change
    rename_column :users, :fisrt_name, :first_name
  end
end
