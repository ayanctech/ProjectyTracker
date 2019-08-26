class ChangeNotificationsColumn < ActiveRecord::Migration[5.2]
  def change
    remove_column :notifications, :name, :string
    add_column :notifications, :notify_name, :string
  end
end
