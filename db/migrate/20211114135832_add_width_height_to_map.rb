class AddWidthHeightToMap < ActiveRecord::Migration[6.0]
  def change
    add_column :maps, :width, :float
    add_column :maps, :height, :float
  end
end
