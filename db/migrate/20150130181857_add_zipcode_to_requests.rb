class AddZipcodeToRequests < ActiveRecord::Migration
  def change
    add_column :requests, :zipcode, :integer
  end
end
