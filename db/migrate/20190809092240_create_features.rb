class CreateFeatures < ActiveRecord::Migration[5.2]
  def change
    create_table :features do |t|
      t.string :name
      t.string :desc
      t.string :feature_id
      t.references :project, foreign_key: true, index: true

      t.timestamps
    end
  end
end
