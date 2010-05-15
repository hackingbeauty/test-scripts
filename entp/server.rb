require 'socket'
server = TCPServer.new(4000)
c = server.accept
c.puts "Well, hello there."
user_input = gets
c.puts user_input
c.close