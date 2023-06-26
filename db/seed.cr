require "json"

class TravelsPlansSeed
  include JSON::Serializable

  @[JSON::Field(key: "travel_stops")]
  property travel_stops : String

  getter id : Int32?

  def create
    travels_plan = build
    travels_plan.save!
    @id = travels_plan.id
  end

  def self.create_list(travel_stops)
    travel_stops.each(&.create)
  end

  private def build
    TravelsPlans.new.tap do |travels_plan|
      travels_plan.travel_stops = travel_stops
    end
  end
end

Sam.namespace "db" do
  task "seed" do
    travel_stops = Array(TravelsPlansSeed).from_json(File.read(File.join(__DIR__, "seeds", "travels_plans.json")))
    TravelsPlansSeed.create_list(travel_stops)
  end
end
