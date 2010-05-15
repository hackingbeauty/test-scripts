class Converter
  
  def convert
    puts "Enter Fahrenheit degrees:"  
    STDOUT.flush  
    fahrDeg = gets.chomp  
    puts "Fahrenheit: " + fahrDeg + "F"
    celsiusDeg = (fahrDeg.to_i - 32) / 1.8
    puts "Celsius: " + format("%.2f",celsiusDeg) + "C"
  end 

end

puts Converter.new.convert

