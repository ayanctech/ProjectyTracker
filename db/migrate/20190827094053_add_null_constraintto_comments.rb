class AddNullConstrainttoComments < ActiveRecord::Migration[5.2]
  def change
    change_column_null :comments, :content, false
    change_column_null :comments, :commenter_name, false
  end
end
