class RemoveStatusFromTodos < ActiveRecord::Migration[6.0]
  def change
    remove_column :todos, :status, :integer
  end
end
