class MyArray < Array
#  include Enumerable - don't need enumerable because Array already has it
  
  def each
    i = 0
    until i == size
      puts "I'm about to yield #{self[i]}"
      yield self[i]
      i += 1
    end
    self
  end
  
end

a = MyArray.new
a.concat([1,2,3,4,5])
p a.any? {|x| x > 3}

a.each {|x| puts x * 10}

