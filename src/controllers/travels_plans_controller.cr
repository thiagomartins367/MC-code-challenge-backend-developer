require "../services/travels_plans_service"
require "../repository/travels_plans_repository"

module Api
  class TravelsPlanController
    def initialize(@service = TravelsPlanService)
    end

    getter :service

    def self.entity_factory : Api::TravelsPlanService
      repository : TravelsPlanRepository = TravelsPlanRepository.new
      service : Api::TravelsPlanService = TravelsPlanService.new(repository)
      service
    end

    post "/travel_plans" do |context|
      response : HTTP::Server::Response = context.response
      request_body = context.params.json
      result : TravelsPlanStruct = entity_factory.create_travels_plan(request_body)
      if result.is_a?(Error)
        status_code : Int32 = result.status_code
        message : String = result.message
        message_json : String = {message: message}.to_json
        halt context, status_code: status_code, response: message_json
      end
      response.status_code = 201
      result.to_json
    end

    get "/travel_plans" do |context|
      response : HTTP::Server::Response = context.response
      result : Array(TravelsPlanStruct) = entity_factory.get_all_travels_plan
      if result.is_a?(Error)
        status_code : Int32 = result.status_code
        message : String = result.message
        message_json : String = {message: message}.to_json
        halt context, status_code: status_code, response: message_json
      end
      response.status_code = 200
      result.to_json
    end

    get "/travel_plans/:id" do |context|
      response : HTTP::Server::Response = context.response
      id : String = context.params.url["id"]
      result : TravelsPlanStruct | Error = entity_factory.get_travels_plan_by_id(id)
      if result.is_a?(Error)
        status_code : Int32 = result.status_code
        message : String = result.message
        message_json : String = {message: message}.to_json
        halt context, status_code: status_code, response: message_json
      end
      response.status_code = 200
      result.to_json
    end

    put "/travel_plans/:id" do |context|
      response : HTTP::Server::Response = context.response
      id : String = context.params.url["id"]
      request_body = context.params.json
      result : TravelsPlanStruct | Error = entity_factory.update_travels_plan(id, request_body)
      if result.is_a?(Error)
        status_code : Int32 = result.status_code
        message : String = result.message
        message_json : String = {message: message}.to_json
        halt context, status_code: status_code, response: message_json
      end
      response.status_code = 200
      result.to_json
    end

    delete "/travel_plans/:id" do |context|
      response : HTTP::Server::Response = context.response
      id : String = context.params.url["id"]
      result : Error | Nil = entity_factory.delete_travels_plan(id)
      if result.is_a?(Error)
        status_code : Int32 = result.status_code
        message : String = result.message
        message_json : String = {message: message}.to_json
        halt context, status_code: status_code, response: message_json
      end
      response.status_code = 204
    end
  end
end
