class CreateSolutions < ActiveRecord::Migration
  def change
    create_table :solutions do |t|
      t.text :content
      t.belongs_to :task, foreign_key: true, index: true, null: false
    end
  end
end
