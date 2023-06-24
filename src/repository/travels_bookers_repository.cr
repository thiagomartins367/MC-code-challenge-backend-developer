module Api
  class TravelsBookerRepository
    def initialize(@model = TravelsBooker)
    end

    getter :model

    def create_travels_booker(travel_stops_string : String) : TravelsBooker
      new_travels_booker : TravelsBooker = model.create({travel_stops: travel_stops_string})
      new_travels_booker
    end

    def get_all_travels_booker : Array(TravelsBooker)
      travels_bookers : Array(TravelsBooker) = model.all.to_a
      travels_bookers
    end

    def get_travels_booker_by_id(id : String) : TravelsBooker | Nil
      travels_booker : TravelsBooker | Nil = model.find(id)
      travels_booker
    end

    def update_travels_booker(travels_booker : TravelsBooker, travel_stops_string : String) : Bool
      travels_booker.update({travel_stops: travel_stops_string})
    end

    def delete_travels_booker(travels_booker : TravelsBooker) : Bool
      travels_booker.destroy
    end
  end
end
