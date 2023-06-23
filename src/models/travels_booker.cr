require "jennifer_twin"

class TravelsBooker < Jennifer::Model::Base
  with_timestamps

  mapping(
    id: Primary32,
    travel_stops: {type: String, default: ""},
    created_at: Time?,
    updated_at: Time?,
  )
end

class TravelsBookerTwin
  include JenniferTwin

  map_fields TravelsBooker
end
