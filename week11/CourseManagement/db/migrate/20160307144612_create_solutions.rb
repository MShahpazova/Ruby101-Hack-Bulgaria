class CreateSolutions < ActiveRecord::Migration
  def change
    create_table :solutions do |t|
      t.text :content, null: false
      # t.belongs_to :task , foreign_key: true, index: true, null: false
      t.references :task
      t.timestamps null: false
    end
  end
end
