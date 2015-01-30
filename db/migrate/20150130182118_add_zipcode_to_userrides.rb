class AddZipcodeToUserrides < ActiveRecord::Migration
  def change
    add_column :userrides, :zipcode, :integer
  end
end
