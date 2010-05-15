#"" f(n) = f(n-1) + n2

class Square
  
  def find_squares_recursively(num)
    unless num == 0 
      result = find_squares_recursively(num - 1).to_i + (num * num)
    end

  end

end
  
puts Square.new.find_squares_recursively(2)