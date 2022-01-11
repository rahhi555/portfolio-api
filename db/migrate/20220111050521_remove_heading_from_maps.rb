class RemoveHeadingFromMaps < ActiveRecord::Migration[6.0]
  def up
    execute <<~SQL
      ALTER TABLE maps
        DROP CONSTRAINT Heading;
    SQL

    remove_column :maps, :heading
  end

  def down
    add_column :maps, :heading, :integer

    execute <<~SQL
      ALTER TABLE maps
        ADD CONSTRAINT Heading
          CHECK (
            heading BETWEEN 0 AND 360
          );
    SQL
  end
end
