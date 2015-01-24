class CreateRides < ActiveRecord::Migration
  def change
    create_table :rides do |t|
      t.integer :num_seats

      t.timestamps
    end
  end
end
