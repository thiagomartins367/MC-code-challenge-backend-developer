module Api
  class TravelsPlanRepository
    def initialize(@model = TravelsPlans)
    end

    getter :model

    def create_travels_plan(travel_stops_string : String) : TravelsPlans
      new_travels_plan : TravelsPlans = model.create({travel_stops: travel_stops_string})
      new_travels_plan
    end

    def get_all_travels_plan : Array(TravelsPlans)
      travel_plans : Array(TravelsPlans) = model.all.to_a
      travel_plans
    end

    def get_travels_plan_by_id(id : String) : TravelsPlans | Nil
      travels_plan : TravelsPlans | Nil = model.find(id)
      travels_plan
    end

    def update_travels_plan(travels_plan : TravelsPlans, travel_stops_string : String) : Bool
      travels_plan.update({travel_stops: travel_stops_string})
    end

    def delete_travels_plan(travels_plan : TravelsPlans) : Bool
      travels_plan.destroy
    end
  end
end
