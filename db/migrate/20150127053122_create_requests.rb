class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.string :user_address
      t.integer :state

      t.timestamps
    end
  end
end
