require "../services/travels_bookers_service"
require "../repository/travels_bookers_repository"

module Api
  class TravelsBookerController
    def initialize(@service = TravelsBookerService)
    end

    getter :service

    def self.entity_factory
      repository = TravelsBookerRepository.new
      service = TravelsBookerService.new(repository)
      service
    end

    before_all "/travel_plans" do |context|
      response = context.response
      response.headers["Content-Type"] = "application/json"
    end

    post "/travel_plans" do |context|
      response = context.response
      params = context.params
      result = entity_factory.create_travels_booker(params.json)
      if result.is_a?(Error)
        status_code = result.status_code
        message = result.message
        message_json = {message: message}.to_json
        halt context, status_code: status_code, response: message_json
      end
      response.status_code = 201
      result.to_json
    end

    get "/travel_plans" do |context|
      response = context.response
      result = entity_factory.get_all_travels_booker
      if result.is_a?(Error)
        status_code = result.status_code
        message = result.message
        message_json = {message: message}.to_json
        halt context, status_code: status_code, response: message_json
      end
      response.status_code = 200
      result.to_json
    end
  end
end
