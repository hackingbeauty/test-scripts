# For all 6-digit numbers from 100000 to 999999, find the numbers that, 
# if you add the top three digits to the bottom three digits, and square the result, 
# it will equal the original number.
# 
# For example, for 123456, you’d add 123 and 456, which equals 579. 
# Then, square that sum, which yields 579 * 579 = 335241. 335241 ≠ 123456, so 123456 is not in the set.
#
# Reference site: http://foohack.com/2008/07/programming-puzzles-and-our-mismatch-problem/

class SquareTheSum

	def computeAnswer
		
		100000.upto(999999) do |i|
			
			initialNum = i.to_s 
			first3 = initialNum.slice(0..2)
			first3Num = first3.to_i
			second3 = initialNum.slice(3..5)
			second3Num = second3.to_i
			squareRes = (first3Num + second3Num) * (first3Num + second3Num)
			
			if (i == squareRes)
				puts "Final answer is " + initialNum
			end
			 
		end
		 
	end 

end 

puts SquareTheSum.new.computeAnswer
