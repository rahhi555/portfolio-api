class AddTodoListToSvg < ActiveRecord::Migration[6.0]
  def change
    add_reference :svgs, :todo_list, null: true, foreign_key: true
  end
end
