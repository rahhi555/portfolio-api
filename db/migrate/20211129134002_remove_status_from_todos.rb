class RemoveStatusFromTodos < ActiveRecord::Migration[6.0]
  def change
    remove_column :todos, :status
  end
end
