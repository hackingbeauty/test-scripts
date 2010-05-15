def bonobos(x)
  return 1 if x == 1 # Special case
  return nil unless x > 1
  y = x.to_i/10.0
  # puts 'y is = ' + y.to_s
  z = 10**(Math.log10(y).ceil)
  # puts 'z is = ' + z.to_s
  return (z/2).ceil if y <= z/2
  return z
end

puts bonobos(ARGV[0].to_i)
 
# Does this work?
# require 'pp'
# pp [1, 5, 10, 11, 50, 51, 100, 101, 500, 501, 10001, 50000, 50001].map { |x| [x, blah(x)] }
#  
#[[1, 1],
# [5, 1],
# [10, 1],
# [11, 5],
# [50, 5],
# [51, 10],
# [100, 10],
# [101, 50],
# [500, 50],
# [501, 100],
# [10001, 5000],
# [50000, 5000],
# [50001, 10000]]