class CreateTravelsPlans < Jennifer::Migration::Base
  def up
    create_table :travels_plans do |t|
      t.string :travel_stops, {:null => false}

      t.timestamps
    end
  end

  def down
    drop_table :travels_plans if table_exists? :travels_plans
  end
end
