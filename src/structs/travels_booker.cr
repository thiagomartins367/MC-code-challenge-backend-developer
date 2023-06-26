struct TravelsBookerStruct
  include JSON::Serializable # Necessário para construir JSON da struct

  def initialize(
    @id : Int32,
    @travel_stops : String | Array(Int32)
  )
  end

  getter :id
  getter :travel_stops
end
