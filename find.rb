require 'file'

Class FindMe

	theFile = file.open('/etc/passwd')

	while(line=theFile.get)
	
		puts 'ya'
	end

end

FindMe.new
puts 'open'
