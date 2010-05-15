require 'rubygems'
require 'rack'



class App
  def call(env)
    request  = Rack::Request.new(env)
    response = Rack::Response.new

    response['Content-Type'] = 'text/html'
    # response.write env.inspect
    response.write "<h1>thoughtbot training</h1>"

    response.finish
  end
end

run App.new