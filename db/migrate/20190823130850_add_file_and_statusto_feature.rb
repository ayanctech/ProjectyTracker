class AddFileAndStatustoFeature < ActiveRecord::Migration[5.2]
  def change
    add_column :features, :status, :string, default: "none"
  end
end
