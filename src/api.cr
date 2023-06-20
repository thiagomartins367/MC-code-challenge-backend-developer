require "kemal"
require "json"

# TODO: Write documentation for `Api`
module Api
  VERSION = "0.1.0"

  # TODO: Put your code here
  get "/" do |env|
    begin
      file_path = "./public/docs/index.html"
      file_content = File.read(file_path)
      env.response.headers["Content-Type"] = "text/html"
      env.response.print file_content
    rescue ex : File::Error
      env.response.headers["Content-Type"] = "text/plain"
      halt env, status_code: 404, response: "Document not found!"
    end
  end

  Kemal.run
end
