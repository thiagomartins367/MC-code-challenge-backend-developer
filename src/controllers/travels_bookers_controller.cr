require "../services/travels_bookers_service"

module Api
  class TravelsBookerController
    post "/travel_plans" do |context|
      response = context.response
      params = context.params
      result = TravelsBookerService.create_travels_booker(params.json)
      response.headers["Content-Type"] = "application/json"
      response.status_code = 201
      result.to_json
    end
  end
end
