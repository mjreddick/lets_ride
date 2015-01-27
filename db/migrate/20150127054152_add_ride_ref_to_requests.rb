class AddRideRefToRequests < ActiveRecord::Migration
  def change
    add_reference :requests, :ride, index: true
  end
end
