class ChangeNotifications < ActiveRecord::Migration[5.2]
  def change
    remove_column :notifications, :user_id
    remove_column :notifications, :recipient_id
    remove_column :notifications, :action
    remove_column :notifications, :notifiable_type
    remove_column :notifications, :notifiable_id

    add_column :notifications, :name, :string
  end
end
