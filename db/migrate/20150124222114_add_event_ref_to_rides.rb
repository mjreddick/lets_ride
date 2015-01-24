class AddEventRefToRides < ActiveRecord::Migration
  def change
    add_reference :rides, :event, index: true
  end
end
