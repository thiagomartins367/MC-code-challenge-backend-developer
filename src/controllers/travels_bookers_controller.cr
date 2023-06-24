require "../services/travels_bookers_service"
require "../repository/travels_bookers_repository"

module Api
  class TravelsBookerController
    def initialize(@service = TravelsBookerService)
    end

    getter :service

    def self.entity_factory : Api::TravelsBookerService
      repository : TravelsBookerRepository = TravelsBookerRepository.new
      service : Api::TravelsBookerService = TravelsBookerService.new(repository)
      service
    end

    post "/travel_plans" do |context|
      response : HTTP::Server::Response = context.response
      request_body = context.params.json
      result : TravelsBookerStruct = entity_factory.create_travels_booker(request_body)
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
      result : Array(TravelsBookerStruct) = entity_factory.get_all_travels_booker
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
      result : TravelsBookerStruct | Error = entity_factory.get_travels_booker_by_id(id)
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
      result : TravelsBookerStruct | Error = entity_factory.update_travels_booker(id, request_body)
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
      result : Error | Nil = entity_factory.delete_travels_booker(id)
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
