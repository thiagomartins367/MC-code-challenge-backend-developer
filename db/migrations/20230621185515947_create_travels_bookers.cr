class CreateTravelsBookers < Jennifer::Migration::Base
  def up
    create_table :travels_bookers do |t|
      t.string :travel_stops, {:null => false}

      t.timestamps
    end
  end

  def down
    drop_table :travels_bookers if table_exists? :travels_bookers
  end
end
