class CreateTodoStatuses < ActiveRecord::Migration[6.0]
  def change
    create_table :todo_statuses do |t|
      t.references :svg, null: false, foreign_key: true
      t.references :todo, null: false, foreign_key: true
      t.integer :status, null: false, default: 0

      t.timestamps
    end
  end
end
