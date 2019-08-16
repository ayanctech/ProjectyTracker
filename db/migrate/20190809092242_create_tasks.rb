class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :name
      t.string :desc
      t.boolean :completed
      t.datetime :due_date

      t.references :feature, foreign_key: true, index: true

      t.timestamps
    end
  end
end
