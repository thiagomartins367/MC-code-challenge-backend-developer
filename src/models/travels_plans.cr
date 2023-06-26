require "jennifer_twin"

class TravelsPlans < Jennifer::Model::Base
  with_timestamps

  mapping(
    id: Primary32,
    travel_stops: {type: String, default: ""},
    created_at: Time?,
    updated_at: Time?,
  )
end

class TravelsPlansTwin
  include JenniferTwin

  map_fields TravelsPlans
end
