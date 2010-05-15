require 'rubygems'
require 'active_record'
		
ActiveRecord::Base.establish_connection(
:adapter  => "mysql",
:host     => "localhost",
:username => "root",
:password => "",
:database => "project_management")


class Project  < ActiveRecord::Base 

	def getProjectTimes
		
		#theProject = Project.find(:all)
		theProject = Project.find(:all,:conditions => "project_name = '#{ARGV}'")
		hours = 0
		
		theProject.each do |project|
			
			hours = hours + project.hours

		end
		
		puts "Hour Total: #{hours}" 
				
	end 
		
end 

Project.new.getProjectTimes