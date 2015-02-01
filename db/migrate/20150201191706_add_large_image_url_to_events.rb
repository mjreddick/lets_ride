class AddLargeImageUrlToEvents < ActiveRecord::Migration
  def change
    add_column :events, :image_url_large, :string
  end
end
