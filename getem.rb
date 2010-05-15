require 'mysql'
require 'net/http'

class GetEm

	def startIt
		puts "it started"
		result = Net::HTTP.get(URI.parse('http://www.macquarium.com'))

	end 

end 

puts GetEm.new.startIt