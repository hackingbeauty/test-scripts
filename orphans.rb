# Find and remove all orphaned files from a site
# Written by Mark Muskardin - November 6, 2008
require 'find'
require 'rubygems'
require 'hpricot'
require 'open-uri'    

class Orphans
	
	def findDirs(rootDir)
		
		count = 0;
		
		#This simple function does a recursive directory listing - how simple!
		Find.find(rootDir) do |file|
			
			fileExtension = File.extname(file)
			
			if (fileExtension.length > 1) && (fileExtension != ".svn-base")			

				p file 
				count += 1
				
				parseLinks(file)
							
			end 
		
		end 
					
		p count 
	
	end 
	
	
	def parseLinks(file)

		page = Hpricot(open(file))
		
		(page/"a").each do |x|
			
			p x
			
		end	
	
	end 

end

puts Orphans.new.findDirs("/Users/mmuskardin/Projects/Pepsico/Intranet Enhancements/trunk/Development/FED/templates/")
#puts Orphans.new.init("/Users/mmuskardin/")
#puts Orphans.new.init("/Users/mmuskardin/Projects/Pepsico/Intranet Enhancements/trunk/Development/FED/templates/")