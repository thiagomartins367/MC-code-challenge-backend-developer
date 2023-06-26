require "kemal"
require "json"
require "../config/config"
require "swagger"
require "swagger/http/server"
require "./docs/build_swagger_doc"

# TODO: Write documentation for `Api`
module Api
  VERSION = "1.0.0"

  # TODO: Put your code here
  before_all "*" do |context|
    response : HTTP::Server::Response = context.response
    response.headers["Content-Type"] = "application/json"
  end

  get "/code_docs" do |context|
    begin
      file_path : String = "./public/docs/index.html"
      file_content : String = File.read(file_path)
      context.response.headers["Content-Type"] = "text/html"
      context.response.print file_content
    rescue ex : File::Error
      context.response.headers["Content-Type"] = "text/plain"
      halt context, status_code: 404, response: "Code documentation not found!"
    end
  end

  get "/license" do |context|
    file_path : String = "./LICENSE"
    file_content : String = File.read(file_path)
    context.response.headers["Content-Type"] = "text/plain"
    context.response.print file_content
  end

  error 500 do
    {message: "internal server error"}.to_json
  end

  kemal_config = Kemal.config
  API_PORT = ENV["API_PORT"]? || "3000"
  API_HOST = ENV["API_HOST"]? || "0.0.0.0"
  kemal_config.port = API_PORT.to_i32
  kemal_config.host_binding = API_HOST

  API_SWAGGER_HOST = ENV["API_SWAGGER_HOST"]? || "localhost"
  API_SWAGGER_PORT = ENV["API_SWAGGER_PORT"]? || "3000"
  swagger_web_entry_path = "/"
  swagger_init_message = "Swagger API documentation is available at"
  swagger_url_message = "#{kemal_config.scheme}://#{API_SWAGGER_HOST}:#{API_SWAGGER_PORT}"
  puts "#{swagger_init_message} #{swagger_url_message}#{swagger_web_entry_path}"

  code_docs_url = "#{kemal_config.scheme}://#{API_SWAGGER_HOST}:#{API_SWAGGER_PORT}/code_docs"
  builder = build_swagger_doc(code_docs_url)
  swagger_api_endpoint = "#{kemal_config.scheme}://#{API_SWAGGER_HOST}:#{API_SWAGGER_PORT}"
  swagger_api_handler = Swagger::HTTP::APIHandler.new(builder.built, swagger_api_endpoint)
  swagger_web_handler = Swagger::HTTP::WebHandler.new(
    swagger_web_entry_path,
    swagger_api_handler.api_url,
  )

  add_handler swagger_api_handler
  add_handler swagger_web_handler

  Kemal.run
end
