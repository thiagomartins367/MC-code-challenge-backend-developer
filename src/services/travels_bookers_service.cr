require "../repository/travels_bookers_repository"

module Api
  class TravelsBookerService
    def initialize(@repository : TravelsBookerRepository)
    end

    getter :repository

    private def format_travels_bookers(travels_bookers : Array(TravelsBooker) | Array(TravelsBookerStruct))
      travels_bookers.map do |travels_booker|
        travel_stops : Array(String) = travels_booker.travel_stops.split(",")
        {
          id:           travels_booker.id,
          travel_stops: travel_stops.map { |location| location.to_i32 },
        }
      end
    end

    def create_travels_booker(request_body)
      travel_stops = request_body["travel_stops"].as(Array)
      travel_stops_string = travel_stops.join(",")
      new_travels_booker = repository.create_travels_booker(travel_stops_string)
      new_travels_booker_formatted = format_travels_bookers([new_travels_booker])
      new_travels_booker_formatted[0]
    end

    def get_all_travels_booker
      travels_bookers = repository.get_all_travels_booker
      travels_booker_formatted = format_travels_bookers(travels_bookers.to_a)
      travels_booker_formatted
    end

    def get_travels_booker_by_id(id)
      travels_booker = repository.get_travels_booker_by_id(id)
      return NamedTuple.new if travels_booker == nil
      travels_booker = travels_booker.as(TravelsBooker)
      travels_booker_formatted = format_travels_bookers([travels_booker])
      travels_booker_formatted[0]
    end

    def update_travels_booker(id, request_body)
      travel_stops = request_body["travel_stops"].as(Array)
      travel_stops_string = travel_stops.join(",")
      is_up_to_date : Bool = repository.update_travels_booker(id, travel_stops_string)
      if !is_up_to_date
        return Error.new(404, "travels_booker with id #{id} not found")
      end
      updated_travels_booker = TravelsBookerStruct.new(id.to_i32, travel_stops_string)
      updated_travels_booker_formatted = format_travels_bookers([updated_travels_booker])
      updated_travels_booker_formatted[0]
    end
  end
end
