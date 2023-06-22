require "kemal"
require "json"
require "../config/config"

# TODO: Write documentation for `Api`
module Api
  VERSION = "0.1.0"

  # TODO: Put your code here
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

  Kemal.run
end
