require "json"

class TravelsBookersSeed
  include JSON::Serializable

  @[JSON::Field(key: "travel_stops")]
  property travel_stops : String

  getter id : Int32?

  def create
    travel_booker = build
    travel_booker.save!
    @id = travel_booker.id
  end

  def self.create_list(travel_stops)
    travel_stops.each(&.create)
  end

  private def build
    TravelsBooker.new.tap do |travel_booker|
      travel_booker.travel_stops = travel_stops
    end
  end
end

Sam.namespace "db" do
  task "seed" do
    travel_stops = Array(TravelsBookersSeed).from_json(File.read(File.join(__DIR__, "seeds", "travels_bookers.json")))
    TravelsBookersSeed.create_list(travel_stops)
  end
end
