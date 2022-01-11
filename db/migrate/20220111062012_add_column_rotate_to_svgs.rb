class AddColumnRotateToSvgs < ActiveRecord::Migration[6.0]
  def change
    add_column :svgs, :rotate, :float, null: false, default: 0
  end
end
