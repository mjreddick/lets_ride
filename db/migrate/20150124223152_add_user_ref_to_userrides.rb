class AddUserRefToUserrides < ActiveRecord::Migration
  def change
    add_reference :userrides, :user, index: true
  end
end
