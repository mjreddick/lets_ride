class AddMediumImageUrlToEvents < ActiveRecord::Migration
  def change
    add_column :events, :image_url_medium, :string
  end
end
