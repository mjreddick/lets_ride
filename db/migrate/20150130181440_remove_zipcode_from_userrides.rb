class RemoveZipcodeFromUserrides < ActiveRecord::Migration
  def change
  	remove_column :userrides, :zipcode, :string
  end
end
