class CreateRoles < ActiveRecord::Migration[6.0]
  def change
    create_table :roles do |t|
      t.references :plan, null: false, foreign_key: true
      t.string :name, null: false
      t.text :description

      t.timestamps
    end
  end
end
