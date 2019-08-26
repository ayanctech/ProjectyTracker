class AddRecipientNotification < ActiveRecord::Migration[5.2]
  def change
    add_column :notifications, :recipient, :string
  end
end
