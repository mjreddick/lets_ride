class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :eventful_id

      t.timestamps
    end
  end
end
