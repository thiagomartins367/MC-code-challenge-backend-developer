require "../repository/travels_plans_repository"

module Api
  class TravelsPlanService
    def initialize(@repository : TravelsPlanRepository)
    end

    getter :repository

    private def format_travel_plans(
      travel_plans : Array(TravelsPlans) | Array(TravelsPlanStruct)
    ) : Array(TravelsPlanStruct)
      travel_plans.map do |travels_plan|
        travel_stops = travels_plan.travel_stops.as(String)
        travel_stops_array : Array(String) = travel_stops.split(",")
        travel_stops_array_formatted : Array(Int32) = travel_stops_array
          .map { |location| location.to_i32 }
        id = travels_plan.id.as(Int32)
        TravelsPlanStruct.new(id, travel_stops_array_formatted)
      end
    end

    private def verify_travels_plan_exists(id : String) : TravelsPlans | Error
      travels_plan : TravelsPlans | Nil = repository.get_travels_plan_by_id(id)
      if travels_plan == nil
        return Error.new(404, "travels plan with id #{id} not found")
      end
      travels_plan = travels_plan.as(TravelsPlans)
      travels_plan
    end

    def create_travels_plan(request_body) : TravelsPlanStruct
      travel_stops = request_body["travel_stops"].as(Array)
      travel_stops_string : String = travel_stops.join(",")
      new_travels_plan : TravelsPlans = repository.create_travels_plan(travel_stops_string)
      new_travels_plan_formatted : Array(TravelsPlanStruct) = format_travel_plans(
        [new_travels_plan],
      )
      new_travels_plan_formatted[0]
    end

    def get_all_travels_plan : Array(TravelsPlanStruct)
      travel_plans : Array(TravelsPlans) = repository.get_all_travels_plan
      travels_plan_formatted : Array(TravelsPlanStruct) = format_travel_plans(
        travel_plans,
      )
      travels_plan_formatted
    end

    def get_travels_plan_by_id(id : String) : TravelsPlanStruct | Error
      travels_plan : TravelsPlans | Error = verify_travels_plan_exists(id)
      return travels_plan if travels_plan.is_a?(Error)
      travels_plan = travels_plan.as(TravelsPlans)
      travels_plan_formatted : Array(TravelsPlanStruct) = format_travel_plans(
        [travels_plan],
      )
      travels_plan_formatted[0]
    end

    def update_travels_plan(
      id : String,
      request_body
    ) : TravelsPlanStruct | Error
      travels_plan : TravelsPlans | Error = verify_travels_plan_exists(id)
      return travels_plan if travels_plan.is_a?(Error)
      travels_plan = travels_plan.as(TravelsPlans)
      travel_stops = request_body["travel_stops"].as(Array)
      travel_stops_string : String = travel_stops.join(",")
      is_up_to_date : Bool = repository.update_travels_plan(travels_plan, travel_stops_string)
      return Error.new(400, "update travels plan with id #{id} failed") if !is_up_to_date
      updated_travels_plan : TravelsPlanStruct = TravelsPlanStruct
        .new(id.to_i32, travel_stops_string)
      updated_travels_plan_formatted : Array(TravelsPlanStruct) = format_travel_plans(
        [updated_travels_plan],
      )
      updated_travels_plan_formatted[0]
    end

    def delete_travels_plan(id : String) : Nil | Error
      travels_plan : TravelsPlans | Error = verify_travels_plan_exists(id)
      return travels_plan if travels_plan.is_a?(Error)
      travels_plan = travels_plan.as(TravelsPlans)
      is_deleted : Bool = repository.delete_travels_plan(travels_plan)
      return Error.new(400, "delete travels plan with id #{id} failed") if !is_deleted
    end
  end
end
