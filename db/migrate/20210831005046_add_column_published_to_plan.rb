class AddColumnPublishedToPlan < ActiveRecord::Migration[6.0]
  def change
    add_column :plans, :published, :boolean, null: false, default: 0
  end
end
