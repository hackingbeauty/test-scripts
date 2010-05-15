class Vehicle
    def go
      puts "I'm moving"
    end
end

class Car < Vehicle
  #getter/read
  def owner
    @owner
  end
  
  #setter/write
  def owner=(name)
    unless name == "David"
      puts "Only David can own cars"
      return
    end
    @owner = name
  end
  
end

c = Car.new

c.owner = "Michael"

puts c.owner