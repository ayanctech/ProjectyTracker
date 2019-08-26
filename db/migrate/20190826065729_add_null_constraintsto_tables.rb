class AddNullConstraintstoTables < ActiveRecord::Migration[5.2]
  def change
    change_column_null :users, :name, false
    change_column_null :users, :email, false
    change_column_null :features, :name, false
    change_column_null :tasks, :name, false
    change_column_null :notifications, :notify_name, false
  end
end
