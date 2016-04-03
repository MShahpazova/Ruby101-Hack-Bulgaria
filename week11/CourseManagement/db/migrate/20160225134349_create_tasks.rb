class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
       t.string :name
       t.text :description
       t.references :lecture
       t.timestamps null: false
    end
  end
end
