class AddReferencetoNotificatons < ActiveRecord::Migration[5.2]
  def change
    add_reference :notifications, :feature
    add_reference :notifications, :comment
  end
end
