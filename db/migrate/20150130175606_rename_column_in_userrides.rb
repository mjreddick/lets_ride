class RenameColumnInUserrides < ActiveRecord::Migration
  def change
  	rename_column :userrides, :user_address, :zipcode
  end
end
