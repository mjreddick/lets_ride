class AddRequestRefToNotifications < ActiveRecord::Migration
  def change
    add_reference :notifications, :request, index: true
  end
end
