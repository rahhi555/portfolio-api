class AddActiveToPlans < ActiveRecord::Migration[6.0]
  def change
    add_column :plans, :active, :boolean, null: false, default: false
  end
end
