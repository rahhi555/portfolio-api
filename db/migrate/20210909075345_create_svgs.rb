class CreateSvgs < ActiveRecord::Migration[6.0]
  def change
    create_table :svgs do |t|
      t.string :type
      t.references :map, null: false, foreign_key: true
      t.float :x, null: false
      t.float :y, null: false
      t.string :fill, null: false
      t.string :stroke, null: false
      t.string :name, null: false
      t.float :width
      t.float :height
      t.integer :display_time
      t.text :draw_points

      t.index :type
      t.timestamps
    end
  end
end
