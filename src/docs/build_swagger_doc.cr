require "swagger"

def build_swagger_doc(code_docs_url : String)
  code_docs_link_html = "<a href='#{code_docs_url}' target='_blank'>code documentation</a>"
  code_docs = "Visit the API #{code_docs_link_html} to see more."
  builder = Swagger::Builder.new(
    title: "Multiverse Travels Booker API",
    version: "1.0.0",
    description: "#{File.read("./src/docs/doc_description.txt")} <br /> <br /> #{code_docs}",
    terms_url: nil,
    license: Swagger::License.new("MIT", "/license"),
    contact: Swagger::Contact.new(
      "Thiago Martins",
      "thiago17thiago@gmail.com",
      "https://thiagomartins367.github.io",
    ),
  )

  builder.add(Swagger::Object.new("Travels_plan", "object", [
    Swagger::Property.new("id", "integer", "int32", example: 1, required: true),
    Swagger::Property.new("travel_stops", "array", example: "[1, 2]", required: true),
  ]))

  builder.add(Swagger::Object.new("Travels_plan_updated", "object", [
    Swagger::Property.new("id", "integer", "int32", example: 1, required: true),
    Swagger::Property.new("travel_stops", "array", example: "[4, 5, 6]", required: true),
  ]))

  builder.add(Swagger::Object.new("ApiRequest: Travels_plan_body", "object", [
    Swagger::Property.new("travel_stops", "array", example: "[1, 2]", required: true),
  ]))

  builder.add(Swagger::Object.new("ApiRequest: Travels_plan_body_to_update", "object", [
    Swagger::Property.new("travel_stops", "array", example: "[4, 5, 6]", required: true),
  ]))

  builder.add(Swagger::Object.new("ApiResponse: Travels_plan_not_found", "object", [
    Swagger::Property.new(
      "message",
      "string",
      example: "travels plan with id {id} not found",
      required: true,
    ),
  ]))

  builder.add(Swagger::Object.new("ApiResponse: Travels_plan_update_failed", "object", [
    Swagger::Property.new(
      "message",
      "string",
      example: "update travels plan with id {id} failed",
      required: true,
    ),
  ]))

  builder.add(Swagger::Object.new("ApiResponse: Travels_plan_delete_failed", "object", [
    Swagger::Property.new(
      "message",
      "string",
      example: "delete travels plan with id {id} failed",
      required: true,
    ),
  ]))

  builder.add(Swagger::Controller.new("Travel plans", "Travel plans resources", [
    Swagger::Action.new(
      "post",
      "/travel_plans",
      summary: "Add new travels plan",
      description: "Add a new travels plan",
      responses: [
        Swagger::Response.new(
          "201",
          "Return travels plan resource after created",
          "Travels_plan",
          "application/json",
        ),
      ],
      request: Swagger::Request.new("ApiRequest: Travels_plan_body"),
      authorization: false,
    ),

    Swagger::Action.new(
      "get",
      "/travel_plans",
      summary: "Get all travel plans",
      description: "Returns all travel plans",
      responses: [
        Swagger::Response.new(
          "200",
          "Success response: Returns array of travel plans or empty array if there are no data. (Content-Type: application/json)",
          content_type: "application/json",
        ),
      ],
      authorization: false,
    ),

    Swagger::Action.new(
      "get",
      "/travel_plans/{id}",
      summary: "Get travels plan by id",
      description: "Returns a travels plan",
      parameters: [
        Swagger::Parameter.new("id", "path", required: true),
      ],
      responses: [
        Swagger::Response.new("200", "Success response", "Travels_plan", "application/json"),
        Swagger::Response.new(
          "404",
          "Not found travels plan",
          "ApiResponse: Travels_plan_not_found",
          "application/json",
        ),
      ],
      authorization: false,
    ),

    Swagger::Action.new(
      "put",
      "/travel_plans/{id}",
      summary: "Update an existing travels plan",
      description: "Update an existing travels plan by Id",
      parameters: [
        Swagger::Parameter.new("id", "path", required: true),
      ],
      request: Swagger::Request.new(
        "ApiRequest: Travels_plan_body_to_update",
        "Request body data to update travels plan",
        "application/json",
      ),
      responses: [
        Swagger::Response.new(
          "200",
          "Success response",
          "Travels_plan_updated",
          "application/json",
        ),
        Swagger::Response.new(
          "404",
          "Not found travels plan",
          "ApiResponse: Travels_plan_not_found",
          "application/json",
        ),
        Swagger::Response.new(
          "400",
          "Bad request",
          "ApiResponse: Travels_plan_update_failed",
          "application/json",
        ),
      ],
      authorization: false
    ),

    Swagger::Action.new(
      "delete",
      "/travel_plans/{id}",
      summary: "Deletes an existing travels plan",
      description: "Delete an existing travels plan by Id",
      parameters: [
        Swagger::Parameter.new("id", "path", required: true),
      ],
      responses: [
        Swagger::Response.new("204", "No Content"),
        Swagger::Response.new(
          "404",
          "Not found travels plan",
          "ApiResponse: Travels_plan_not_found",
          "application/json",
        ),
        Swagger::Response.new(
          "400",
          "Bad request",
          "ApiResponse: Travels_plan_delete_failed",
          "application/json",
        ),
      ],
      authorization: false,
    ),
  ]))

  return builder
end
