class AddIsGoogleMapAddressLatLngZoomToMap < ActiveRecord::Migration[6.0]
  def change
    add_column :maps, :is_google_map, :boolean, default: false
    add_column :maps, :address, :string
    add_column :maps, :lat, :float
    add_column :maps, :lng, :float
    add_column :maps, :zoom, :integer
  end
end
