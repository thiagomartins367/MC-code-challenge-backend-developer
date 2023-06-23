module Api
  class TravelsBookerRepository
    def initialize(@model = TravelsBooker)
    end

    getter :model

    def create_travels_booker(travel_stops_string)
      new_travels_booker = model.create({travel_stops: travel_stops_string})
      new_travels_booker
    end

    def get_all_travels_booker
      travels_bookers = model.all
      travels_bookers
    end

    def get_travels_booker_by_id(id)
      travels_booker : TravelsBooker | Nil = model.find(id)
      travels_booker
    end

    def update_travels_booker(id, travel_stops_string)
      travels_booker : TravelsBooker | Nil = model.find(id)
      return false if travels_booker == nil
      travels_booker = travels_booker.as(TravelsBooker)
      travels_booker.update({travel_stops: travel_stops_string})
    end
  end
end
