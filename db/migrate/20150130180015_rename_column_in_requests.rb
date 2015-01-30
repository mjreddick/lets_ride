class RenameColumnInRequests < ActiveRecord::Migration
  def change
  	rename_column :requests, :user_address, :zipcode
  end
end
