class CreateUserrides < ActiveRecord::Migration
  def change
    create_table :userrides do |t|
      t.string :user_address
      t.boolean :is_driver

      t.timestamps
    end
  end
end
