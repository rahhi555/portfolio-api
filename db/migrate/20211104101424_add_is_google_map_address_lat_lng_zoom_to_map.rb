class AddIsGoogleMapAddressLatLngZoomToMap < ActiveRecord::Migration[6.0]
  def change
    add_column :maps, :is_google_map, :boolean, default: false, comment: 'グーグルマップ使用フラグ'
    add_column :maps, :address, :string, comment: '住所文字列'
    add_column :maps, :heading, :integer, comment: 'マップの回転度数。0~360を範囲とする'
    add_column :maps, :bounds, :json, comment: 'マップの表示範囲。typescriptのgoogle.maps.LatLngBoundsLiteralと同様'

    reversible do |dir|
      dir.up do
        execute <<~SQL
          ALTER TABLE maps
            ADD CONSTRAINT LatLngBoundsLiteral
              CHECK (
                JSON_SCHEMA_VALID(
                  '{
                    "type":"object",
                    "properties":{
                    "north":{"type":"number","minimum":-90,"maximum":90},
                    "west":{"type":"number","minimum":-180,"maximum":180},
                    "south":{"type":"number","minimum":-90,"maximum":90},
                    "east":{"type":"number","minimum":-180,"maximum":180}
                    },
                    "required":["north","west","south","east"]
                  }',
                  bounds
                )
              ),
            ADD CONSTRAINT Heading
              CHECK (
                heading BETWEEN 0 AND 360
              );
        SQL
      end

      dir.down do
        execute <<-SQL
          ALTER TABLE maps
            DROP CONSTRAINT LatLngBoundsLiteral,
            DROP CONSTRAINT heading;
        SQL
      end
    end
  end
end
