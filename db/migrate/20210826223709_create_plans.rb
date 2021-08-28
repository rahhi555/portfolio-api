class CreatePlans < ActiveRecord::Migration[6.0]
  def change
    create_table :plans do |t|
      t.string :name, null: false
      t.references :user, index: true, foreign_key: true

      t.timestamps
    end
  end
end
