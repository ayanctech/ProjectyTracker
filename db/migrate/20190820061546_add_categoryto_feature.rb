class AddCategorytoFeature < ActiveRecord::Migration[5.2]
  def change
    add_column :features, :category, :string, null: false
    add_column :comments, :category, :string, null: false
  end
end
