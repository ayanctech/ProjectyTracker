class ChangeStatusFeatureDefault < ActiveRecord::Migration[5.2]
  def change
    change_column :features, :status, :string, default: "Started"
  end
end
