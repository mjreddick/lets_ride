class RemoveZipcodeFromRequests < ActiveRecord::Migration
  def change
  	remove_column :requests, :zipcode, :string
  end
end
