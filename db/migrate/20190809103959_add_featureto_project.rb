class AddFeaturetoProject < ActiveRecord::Migration[5.2]
  def change
    add_column :projects, :feature, :string
    add_column :projects, :feature_description, :text
  end
end
