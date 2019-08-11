class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :projects do |t|
      t.string :title, null: false
      t.text :description, null: true

      t.index [:title], unique: true

      t.references :user, foreign_key: true, index: true

      t.timestamps
    end
  end
end
