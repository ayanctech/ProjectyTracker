class RenameFeaturecolumn < ActiveRecord::Migration[5.2]
  def change
    rename_column :features, :feature_id, :feature_token_id
  end
end
