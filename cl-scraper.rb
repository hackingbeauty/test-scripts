require 'rubygems'  
require 'hpricot'  
require 'open-uri'  
require 'parsedate'
require 'mysql'
require 'amatch'
require 'active_record'
require 'net/smtp'

$db = Mysql::new("localhost", "root", "", "getem")
  
  
def initialize_db

		ActiveRecord::Base.establish_connection(
	:adapter  => "mysql",
	:host     => "localhost",
	:username => "root",
	:password => "",
	:database => "getem"
)

	puts "inside initialize_db"

	ActiveRecord::Schema.define do
		
		create_table :jobs do |table|
			table.column :job_date, :string
			table.column :job_time, :string
			table.column :job_city, :string
			table.column :job_title, :string
			table.column :job_email, :string
		end
	
	end
	 
end   
  
  
  
class Job < ActiveRecord::Base

	def insert_into_db (jobDate,jobTime,jobCity,jobTitle,jobEmail) #this is how you declare a static method in Ruby.  Append the method with the class name

		Job.create(:job_date => jobDate,:job_time => jobTime,:job_city => jobCity, :job_title => jobTitle, :job_email => jobEmail)
		
		puts "inserted"
		
		send_message(jobEmail,jobTitle)

	end 
	
	def send_message(jobEmail,jobTitle)
		
		puts "I would like to apply for the " + jobTitle + "position. - " + jobEmail	
	  
	  from_addr = 'markmuskardin@fromthought2web.com'
	  to_addr = 'markmuskardin@gmail.com'
	  
	  mailtext = "blah blah test."
	  
	  Net::SMTP.start('mail.fromthought2web.com', 25, 'markmuskardin@fromthought2web.com','orangutan78',:plain) do |smtp|
	    smpt.sendmail(mailtext,)
	  end
	
	end 

end 

   
class GoGetEm
	
	def sendMessage
	
		puts "inside sendMessage"
		
	end 
	
	# Insert into database stuff
	def insert_into_db(city,jobTitle,html_link)
		
		href1 = html_link.scan(/<a href.*?\/.*?.html/m).to_s
		href2 = href1.slice(9..-1).to_s
		url = "http://"+city+".craigslist.org"+href2

		#$db.query("CREATE TABLE IF NOT EXISTS links (city text, link_title text, link text)")
		#$db.query("INSERT INTO links VALUES ('#{city}','#{jobTitle}','#{url}')")
	
		get_job(url,city,jobTitle)
			
	end
	
	def get_job(url,city,jobTitle)
		
		begin 
		
			job = Hpricot(open(url))
	
			str=job.to_s
			
			dateLine = str.scan(/Date:.*?EDT/).to_s
			
			emailAddy = ""
			
			if dateLine != ""
						
				(job/"a").each do |x|
					
					emailLine = x.to_s.scan(/mailto:.*?<\/a>/)
	
					asciiChar = emailLine.to_s.split(';')
					
					emailLine.to_s.split(';').each do |char|
						
						if(char.include? "mailto:")
						
							charCode = char.slice(9..-1)
							
						else
						
							charCode = char.slice(2..-1)
													
						end 
						
							
						puts "char is " + charCode 
						
						charCode2 = charCode.to_i.chr
						
						emailAddy += charCode2.to_s
	
					end
			
				end 
				
				emailAddy2 = emailAddy.slice(0..(emailAddy.length/2))
				
				theDate = dateLine.scan(/2.*?,/).to_s
				theDate2 = theDate.slice(0..9)
				theTime = dateLine.scan(/,.*?EDT/).to_s
				theTime2 = theTime.slice(2..8)
				
				Job.new.insert_into_db(theDate2,theTime2,city,jobTitle,emailAddy2)
							
# 				$db.query("CREATE TABLE IF NOT EXISTS jobs (job_date text, job_time text, job_city text, job_title text, job_email text)")
# 				$db.query("INSERT INTO jobs VALUES ('#{theDate2}','#{theTime2}','#{city}','#{jobTitle}','#{emailAddy2}')")
			
				puts theDate2 + " - " + theTime2
					
			end 
			
		rescue 
			
		end 
		
	end 

	
	
	def get_links(doc,city)  
			
		(doc/"a").each do |href|
			job_title = href.inner_html
			html_link = href
			html_title = job_title.gsub(/'/,'')
			html_title2 = html_title.gsub(/,/,'')
			html_link2 = html_link.to_s.gsub(/'/,'')
			insert_into_db(city,html_title2.rstrip,html_link2.rstrip)
		end 
	
	end  
	

	
	def start_it
	   
	   initialize_db
	   
		sites = %w(http://portland.craigslist.org/eng http://denver.craigslist.org/eng http://austin.craigslist.org/eng http://newyork.craigslist.org/eng http://atlanta.craigslist.org/eng http://seattle.craigslist.org/eng) 

		sites.each do |site|
			cityName = site.to_s.split('.')[0]	#get everything before the first dot
			cityClean = cityName.slice(7..-1)	#remove the http and juust get the city name
			dataStream = Hpricot(open(site)) #open a channel to each site
			get_links(dataStream,cityClean)
		end   
			
	end 

end 

GoGetEm.new.start_it