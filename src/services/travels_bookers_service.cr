require "../repository/travels_bookers_repository"

module Api
  class TravelsBookerService
    def self.create_travels_booker(request_body)
      travel_stops = request_body["travel_stops"].as(Array)
      travel_stops_string = travel_stops.join(",")
      new_travel_stops = TravelsBookerRepository.create_travels_booker(travel_stops_string)
      new_travel_stops_array = new_travel_stops["travel_stops"].as_s.split(",")
      new_travel_stops_formatted = new_travel_stops_array.map { |location| location.to_i32 }
      {id: new_travel_stops["id"], travel_stops: new_travel_stops_formatted}
    end
  end
end
