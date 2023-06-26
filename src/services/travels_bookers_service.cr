require "../repository/travels_bookers_repository"

module Api
  class TravelsBookerService
    def initialize(@repository : TravelsBookerRepository)
    end

    getter :repository

    private def format_travels_bookers(
      travels_bookers : Array(TravelsBooker) | Array(TravelsBookerStruct)
    ) : Array(TravelsBookerStruct)
      travels_bookers.map do |travels_booker|
        travel_stops = travels_booker.travel_stops.as(String)
        travel_stops_array : Array(String) = travel_stops.split(",")
        travel_stops_array_formatted : Array(Int32) = travel_stops_array
          .map { |location| location.to_i32 }
        id = travels_booker.id.as(Int32)
        TravelsBookerStruct.new(id, travel_stops_array_formatted)
      end
    end

    private def verify_travels_booker_exists(id : String) : TravelsBooker | Error
      travels_booker : TravelsBooker | Nil = repository.get_travels_booker_by_id(id)
      if travels_booker == nil
        return Error.new(404, "travels_booker with id #{id} not found")
      end
      travels_booker = travels_booker.as(TravelsBooker)
      travels_booker
    end

    def create_travels_booker(request_body) : TravelsBookerStruct
      travel_stops = request_body["travel_stops"].as(Array)
      travel_stops_string : String = travel_stops.join(",")
      new_travels_booker : TravelsBooker = repository.create_travels_booker(travel_stops_string)
      new_travels_booker_formatted : Array(TravelsBookerStruct) = format_travels_bookers(
        [new_travels_booker],
      )
      new_travels_booker_formatted[0]
    end

    def get_all_travels_booker : Array(TravelsBookerStruct)
      travels_bookers : Array(TravelsBooker) = repository.get_all_travels_booker
      travels_booker_formatted : Array(TravelsBookerStruct) = format_travels_bookers(
        travels_bookers,
      )
      travels_booker_formatted
    end

    def get_travels_booker_by_id(id : String) : TravelsBookerStruct | Error
      travels_booker : TravelsBooker | Error = verify_travels_booker_exists(id)
      return travels_booker if travels_booker.is_a?(Error)
      travels_booker = travels_booker.as(TravelsBooker)
      travels_booker_formatted : Array(TravelsBookerStruct) = format_travels_bookers(
        [travels_booker],
      )
      travels_booker_formatted[0]
    end

    def update_travels_booker(
      id : String,
      request_body
    ) : TravelsBookerStruct | Error
      travels_booker : TravelsBooker | Error = verify_travels_booker_exists(id)
      return travels_booker if travels_booker.is_a?(Error)
      travels_booker = travels_booker.as(TravelsBooker)
      travel_stops = request_body["travel_stops"].as(Array)
      travel_stops_string : String = travel_stops.join(",")
      is_up_to_date : Bool = repository.update_travels_booker(travels_booker, travel_stops_string)
      return Error.new(400, "update travels_book with id #{id} failed") if !is_up_to_date
      updated_travels_booker : TravelsBookerStruct = TravelsBookerStruct
        .new(id.to_i32, travel_stops_string)
      updated_travels_booker_formatted : Array(TravelsBookerStruct) = format_travels_bookers(
        [updated_travels_booker],
      )
      updated_travels_booker_formatted[0]
    end

    def delete_travels_booker(id : String) : Nil | Error
      travels_booker : TravelsBooker | Error = verify_travels_booker_exists(id)
      return travels_booker if travels_booker.is_a?(Error)
      travels_booker = travels_booker.as(TravelsBooker)
      is_deleted : Bool = repository.delete_travels_booker(travels_booker)
      return Error.new(400, "delete travels_book with id #{id} failed") if !is_deleted
    end
  end
end
