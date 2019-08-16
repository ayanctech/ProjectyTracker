class AddUsertoTask < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :user_id, :bigint
    add_foreign_key :tasks, :users
    remove_column :tasks, :due_date, :datetime
    remove_column :tasks, :desc

  end
end
