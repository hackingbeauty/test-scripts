#!/usr/bin/ruby

class Bubble

  def start
    arr = Array.new
    arr[0] = 700
    arr[1] = 255
    arr[2] = 100
    arr[3] = 793
    
    list = bubble_sort(arr)

    puts list.size
    
    for i in list
      puts i
    end

  end

  def bubble_sort(list)
    return list if list.size <= 1 # already sorted

    loop do
      swapped = false
      0.upto(list.size-2) do |i|
        if list[i] > list[i+1]
          list[i], list[i+1] = list[i+1], list[i] # swap values
          swapped = true
        end
      end
      break unless swapped
    end

    list
  end

end

Bubble.new.start
