class AddRideRefToUserrides < ActiveRecord::Migration
  def change
    add_reference :userrides, :ride, index: true
  end
end
