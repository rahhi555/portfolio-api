class CreateMaps < ActiveRecord::Migration[6.0]
  def change
    create_table :maps do |t|
      t.references :plan, null: false, foreign_key: true
      t.string :name, null: false
      t.index [:plan_id, :name], { unique: true }

      t.timestamps
    end
  end
end
