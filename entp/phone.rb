class Phone
  attr_accessor :name
  attr_accessor :number
end

class PhoneBook
  
  def initialize
    @phoneNumbers = Hash.new
  end
  
  def start
    while true 
      print "Action: "
      STDOUT.flush
      input=gets.chomp
      if(input=="add")
        add
      elsif(input=="delete")
        delete
      elsif(input=="exit")
        display
        Kernel.exit
      end#end if
    end#end while
  end

  def add
    print "New name:"
    name=gets.chomp
    print "New number:"
    number=gets.chomp
    phone=Phone.new
    phone.name=name
    phone.number=number
    if(!@phoneNumbers.has_key?(phone.name))
      @phoneNumbers[phone.name] = number
      if File.exists?("phone_numbers.txt")
        File.open("phone_numbers.txt", 'a') {|f| f.write(phone.name+","+phone.number + "\n") }
      else
        File.open("phone_numbers.txt", 'w') {|f| f.write(phone.name+","+phone.number + "\n") }
      end
    else
      puts 'An entry for that user already exists'
    end
  end
  
  def delete
    print "Name to delete:"
    name=gets.chomp
    if(@phoneNumbers.has_key?(name))
      @phoneNumbers.delete(name)
      puts name + ' was deleted from your phonebook'
    end
  end
  
  def display
    @phoneNumbers.each do |p|
     puts p[0] + " " + p[1]
    end
  end
  
end

PhoneBook.new.start

