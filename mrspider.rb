require 'mysql'
require 'find'

class MrSpider
	def traverseDir
		count = 0
		Find.find('/Users/mmuskardin/Desktop/emory_arts_backup/') do |path|
			if FileTest.directory?(path)
				Find.find(path) do |file|
					if File.exists?(file)
						fileExtension = File.extname(file)
					
						if ((fileExtension.eql? ".shtml") || (fileExtension.eql? ".jsp"))
							parseFile(file)
						end
						count += 1
						
					end
				end
			end
		end
		puts "There are #{count} files"
	end
	
	def findFile
		
		db = Mysql::new("localhost", "root", "", "mrspider")
		db.query("CREATE TABLE IF NOT EXISTS jpgs (name text, size int)")
		
		Dir['/Users/mmuskardin/Pictures/*.jpg'].each do |file|
			db.query("INSERT INTO jpgs VALUES ('#{file}',  #{File.size(file)})")
			puts file
			
		end
		db.close
	
	end
	
	def insertFile(theLink)
		
		db = Mysql::new("localhost", "root", "", "mrspider")
		db.query("CREATE TABLE IF NOT EXISTS links (name blob)")
		
		hrefLink = theLink
		puts hrefLink
		db.query("INSERT INTO links VALUES ('#{theLink}')")

		db.close
	end


	def parseFile(file)
	
		theFile = File.open(file)
		pattern = "<title>(.*)</title>"
		while (line = theFile.gets)
			#line.scan(/(\w+)\s+<a\b/) do |x|
			
			line.scan(/<a href.*?\/.*?.html\"/m) do |x|
				
				theLink = x
				theLink.scan(/".*?/m)
				puts theLink.scan(/".*?"/m)
				insertFile(theLink.scan(/".*?"/m))
			end
			
		end
		
	end
end

puts MrSpider.new.traverseDir
#line.scan(/<a href.*?a>/m) do |x|
#puts "#{line.scan(/<a href.*?a>/m)}"
