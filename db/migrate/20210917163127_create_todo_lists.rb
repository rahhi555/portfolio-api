class CreateTodoLists < ActiveRecord::Migration[6.0]
  def change
    create_table :todo_lists do |t|
      t.references :plan, null: false, foreign_key: true
      t.string :title, null: false

      t.timestamps
    end
  end
end
