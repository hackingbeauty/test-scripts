
# This module defines a Sudoku::Puzzle class to represent a 9x9
# Sudoko puzzle and also defines exception classes raised for
# invalid input and over-constrained puzzles.  This module also defines
# the method Sudoku.solve to solve a puzzle.  The solve method uses
# the Sudoku.scan method, which is also defined here.
#
# Use this module to solve Sudoku puzzles with code like this:
#
# require 'sudoku'
# puts Sudoku.solve(Sudoku::Puzzle.new(ARGF.readlines))
#
module Sudoku
    
    # The Sudoku::Puzzle class represents the state of a 9x9 Sudoku puzzle.
    class Puzzle
        
        # These constants are used for translating between the external
        # string representation of a puzzle and the internal representation.
        ASCII = ".123456789"
        BIN = "\000\001\002\003\004\005\006\007\010\011"
        
        # This is the initialization method for the class.  It is automatically
        # invoked on new Puzzle instances created with Puzzle.new.  Pass the input
        # puzzle as an array of lines or as a single string.  Use ASCII digits 1
        # to 9 and use the '.' character for unknown cells.  Whitespace,
        # including newlines, will be stripped.
        def initialize(lines)
            if (lines.respond_to? :join)    # if argument looks like an array of lines
                s = lines.join              # Then join them into a single string
            else                            # Otherwise, assume we have a string
                s = lines.dup                # And make a private copy of it
            end
            
            s.gsub!(/\s/,"")
            
            raise Invalid, "Grid is the wrong size" unless s.size == 81
            
            if i = s.index(/[^123456789\.]/)
               raise Invalid, "Illegla character #{s[i,1]} in puzzle" 
            end
            
            s.tr!(ASCII, BIN)
            @grid = s.unpack('c*')
            
            raise Invalid, "Initial puzzle has duplicates" if has_duplicates?
        
        end
        
        def to_s
           (0..8).collect{|r| @grid[r*9,9].pack('c9')}.join("\n").tr(BIN,ASCII) 
        end
                    
        def dup
           copy = super
           @grid = @grid.dup
           copy 
        end 
               
        def[](row,col)
           @grid[row*9 + col] 
        end
        
        def []=(row,col,newvalue)
            unless (0..9).include? newvalue
               @raise Invalid, "illegal cell value"
            end
            @grid[row*9 + col] = newvalue
        end
        
        BoxOfIndex = [
            0,0,0,1,1,1,2,2,2,0,0,0,1,1,1,2,2,2,0,0,0,1,1,1,2,2,2,
            3,3,3,4,4,4,5,5,5,3,3,3,4,4,4,5,5,5,3,3,3,4,4,4,5,5,5,
            6,6,6,7,7,7,8,8,8,6,6,6,7,7,7,8,8,8,6,6,6,7,7,7,8,8,8
        ].freeze
                
        def each_unknown
           0.upto 8 do |row|
               0.upto 8 do |col|
                    index = row*9+col
                    next if @grid[index] != 0
                    box = BoxOfIndex[index]
                    yield row, col, box
               end
           end
        end
        
        def has_duplicates?
           0.upto(8) {|row| return true if rowdigits(row).uniq! }
           0.upto(8) {|col| return true if coldigits(col).uniq! }
           0.upto(8) {|box| return true if boxdigits(box).uniq! }
        end
                     
        # This array holds a set of all Sudoku digits.  Used below.
        AllDigits = [1,2,3,4,5,6,7,8,9].freeze
        
        def possible(row,col,box)
            AllDigits - (rowdigits(row) + coldigits(col) + boxdigits(box))
        end
        
        private # All methods after this line are private to the class
        
        def rowdigits(row)
            # Extract the subarray that represents the row and remove all zeros.
            # Array subtraction is set difference, with duplicate removal.
           @grid[row*9,9] - [0] 
        end
                     
    end
