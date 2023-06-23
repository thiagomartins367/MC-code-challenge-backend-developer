require "kemal"
require "json"
require "../config/config"

# TODO: Write documentation for `Api`
module Api
  VERSION = "0.1.0"

  # TODO: Put your code here
  before_all "*" do |context|
    response = context.response
    response.headers["Content-Type"] = "application/json"
  end

  get "/" do |context|
    begin
      file_path = "./public/docs/index.html"
      file_content = File.read(file_path)
      context.response.headers["Content-Type"] = "text/html"
      context.response.print file_content
    rescue ex : File::Error
      context.response.headers["Content-Type"] = "text/plain"
      halt context, status_code: 404, response: "Document not found!"
    end
  end

  error 500 do
    {message: "internal server error"}.to_json
  end

  Kemal.run
end
