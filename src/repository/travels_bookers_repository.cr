module Api
  class TravelsBookerRepository
    def self.create_travels_booker(travel_stops_string)
      data = TravelsBooker.create({travel_stops: travel_stops_string})
      new_travel_stops_json = data.to_json
      new_travel_stops = JSON.parse(new_travel_stops_json)
      new_travel_stops
    end
  end
end
