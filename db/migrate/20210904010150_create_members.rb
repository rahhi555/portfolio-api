class CreateMembers < ActiveRecord::Migration[6.0]
  def change
    create_table :members do |t|
      t.references :user, null: false, foreign_key: true
      t.references :plan, null: false, foreign_key: true
      t.references :role, foreign_key: true
      t.boolean :accept, default: false

      t.index [:user_id, :plan_id], { unique: true }
      t.timestamps
    end
  end
end
