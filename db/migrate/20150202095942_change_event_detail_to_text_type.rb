class ChangeEventDetailToTextType < ActiveRecord::Migration
  def change
  	change_column(:events, :details, :text)
  end
end
