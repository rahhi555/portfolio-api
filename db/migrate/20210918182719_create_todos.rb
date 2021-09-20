class CreateTodos < ActiveRecord::Migration[6.0]
  def change
    create_table :todos do |t|
      t.references :todo_list, null: false, foreign_key: true
      t.string :title, null: false
      t.text :body
      t.time :begin_time
      t.time :end_time
      t.integer :status

      t.timestamps
    end
  end
end
